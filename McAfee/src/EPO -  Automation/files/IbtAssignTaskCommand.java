package com.mcafee.IbtExtension;

import com.mcafee.epo.core.model.EPOComputer;
import com.mcafee.epo.core.util.EPODateTime;

import com.mcafee.orion.core.auth.OrionUser;
import com.mcafee.orion.core.auth.UserAware;
import com.mcafee.orion.core.cmd.Auditable;
import com.mcafee.orion.core.cmd.CommandException;
import com.mcafee.orion.core.cmd.HelpDisplayer;
import com.mcafee.orion.core.cmd.CommandSpec;
import com.mcafee.orion.core.cmd.VisibleCommandBase;
import com.mcafee.orion.core.cmd.VisibleCommand;
import com.mcafee.orion.core.db.base.DatabaseUtil;
import com.mcafee.orion.core.db.ConnectionBean;
import com.mcafee.orion.core.ext.cmd.ExtensionCommandBase;

import com.mcafee.epo.task.services.ClientTaskServiceInternal;
import com.mcafee.epo.task.services.TaskObjEventHelper;
import com.mcafee.epo.task.model.*;
import com.mcafee.epo.task.dao.TaskAssignmentDBDao;
import com.mcafee.epo.task.dao.TaskObjScheduleDBDao;
import com.mcafee.epo.task.dao.TaskSlotDBDao;
import com.mcafee.epo.core.services.EPOComputerServiceInternal;
import com.mcafee.epo.core.EpoValidateException;
import com.mcafee.orion.core.db.base.Database;
import com.mcafee.orion.core.event.OrionEventDispatchService;
import com.mcafee.orion.core.util.resource.Resource;
import com.mcafee.epo.core.services.EPOComputerService;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Harish Krishnan
 * Date: Sep 24, 2010
 * Time: 2:27:40 PM
 * To change this template use File | Settings | File Templates.
 */
//ExtensionCommandBase
public class IbtAssignTaskCommand extends ExtensionCommandBase
    implements HelpDisplayer, Auditable, UserAware, ConnectionBean, VisibleCommand
{
    //-------------------------------------------------------------------------
    // Command interface implementations
    //-------------------------------------------------------------------------

    // To display the command to the user in the commands list.
    protected CommandSpec createSpec()
    {
        CommandSpec spec = new CommandSpec("ma.assignTask");
        spec.setName("ma.assignTask");
        spec.setResource(getResource());
        spec.setPermissionDescKey("ma.assignTask.permission.desc");
        spec.setShortDescKey("ma.assignTask.short.desc");
        spec.setLongDescKey("ma.assignTask.long.desc");
        return spec;
    }
    
    public boolean authorize (OrionUser user) throws CommandException
    {
        return true;
    }

    public Object invoke () throws Exception
    {
        // Parameters Validation.
        if (m_computer == null || m_product == null || m_type == null || m_name == null || m_settings == null)
        {
            throw new CommandException ("Missing required parameter\n" + getHelpString (HelpType.DETAILED));
        }// End Of Parameters Validation.

        // Computer OR Node Name Validation at ePO.
        EPOComputerServiceInternal computer = new EPOComputerServiceInternal();
        epoComputer = computer.findSystemByName(getConnection(), m_computer);
        if (epoComputer.isEmpty())
        {
            throw new CommandException ("Unable to find computer [" + m_computer + "] in ePO.");
        }

        if (epoComputer.size() > 1)
        {
            throw new CommandException ("Multiple entires in ePO for computer [" + m_computer + "]");
        }// End Of Node entry Validation.

        // Creating the Task Schedules based on the user settings.
        ClientTaskSchedule cTaskSchedule = createTaskSchedule(getConnection (), m_settings);

        // Get the TaskObjectId for the given Task name & type.
        taskObjId = getObjIdForTask(getConnection (), getUser(), m_product, m_type, m_name);

        cTaskAssignment = createTaskAssignment(taskObjId, epoComputer.get(0).getNodeID(), epoComputer.get(0).getNodeType(), 0);
        cTaskAssignment.setTaskScheduleId(cTaskSchedule.getScheduleID());

        ClientTaskServiceInternal clientTaskService = new ClientTaskServiceInternal();
        clientTaskService.setComputerService(new EPOComputerServiceInternal());

        ctt = clientTaskService.getClientTaskTypeByProductAndName(getConnection (), getUser (), m_product, m_type);

        // Create a Task Slot for the given Task Type Id.
        slot = createTaskSlot(getConnection (), ctt.getTaskTypeId());
        cTaskAssignment.setTaskSlotId(slot.getTaskSlotId());

        cTaskAssignment.setTaskSchedule(cTaskSchedule);
        cTaskAssignment.setProductCode(m_product);
        cTaskAssignment.setTaskType(m_type);
        cTaskAssignment.setTaskObjName(m_name);

        TaskAssignmentDBDao taDao = new TaskAssignmentDBDao(getConnection ());
        taDao.save(cTaskAssignment);
        getConnection ().commit();


        try
        {
//            cTaskAssignment = clientTaskService.saveAssignment(getConnection (), getUser(), cTaskAssignment, ctt.getTaskTypeId());

            /* The above "saveAssignment" function of ClientTaskServiceInternal class has some bugs in it & always throws an
             null Exception during its finally block getting executed. Hence i am calling a similar local function "save"
             which does the same thing as "saveAssignment" but excludes the finally block.
             note: The finally block of "saveAssignment" function just does some Audit logging, so no need to worry of missing anything.
             */
            cTaskAssignment = save(getConnection (), getUser(), cTaskAssignment, ctt.getTaskTypeId());
            getConnection ().commit ();
        }
        catch (Exception e)
        {
            throw new CommandException ("Save Assignment Failed: " + e.getMessage(), e);
        }

       
        return true;

    }



    //-------------------------------------------------------------------------
    // Helper Functions for this Class.
    //-------------------------------------------------------------------------

    public String getDescription ()
    {
        return "Assign the task";
    }


    public String getStatusMessage ()
    {
        return "Assign the task";
    }

    public int getPriority ()
    {
        return PRIORITY_HIGH;
    }
    
    public String getDisplayName ()
    {
        return "IBTAssignTaskCommand";
    }

    public String getHelpString (HelpType type)
    {
        switch (type)
        {
            case DETAILED:
                return " - Assigns the specified task name & type to the given Node:\r\n" +
                    "  -computer      (param 1): Computer/Node name\r\n" +
                    "  -type          (param 2): The type (Ex: Deployment/Update) of the task.\r\n" +
                    "  -name          (param 3): The name of the task that you are Assigning.\r\n" +
                    "  -product       (param 4): The productId (Ex: EPOAGENTMETA) of the task.\r\n" +
                    "  -settings      (param 5): The task Schedule settings.\r\n";
            case ONE_LINE:
            default:
                return " - Assigns the specified task name & type to the given Node.";
        }
    }

    
    public static ClientTaskSchedule createTaskSchedule(Connection con, String userSettings) throws Exception
    {
        TaskObjScheduleDBDao tsDao = new TaskObjScheduleDBDao(con);
        ClientTaskSchedule ts = new ClientTaskSchedule();
        ClientTaskSettings settings = new ClientTaskSettings();

        String[] settingStrings = userSettings.split ("`");
        for (String settingString : settingStrings)
        {
            String[] pieces = settingString.split ("\t");
            String value = "";

         /* There should be at least 2 pieces: the section and the setting. The
            value may be missing if it is empty. */
            if (pieces.length < 2)
            {
                throw new CommandException ("Settings must have the format <section><tab><setting>[<tab><value>]: '"
                    + settingString + "'");
            }
            else if (pieces.length == 3)
            {
                value = pieces[2];
            }
            settings.addSetting (pieces[0], pieces[1], value);
        }

        ts.setTaskSettings(settings);
        tsDao.save(ts);
        con.commit();
        return ts;
    }

    public static int getObjIdForTask(Connection con, OrionUser user, String product,
                                      String type, String name) throws Exception
    {
        List<ClientTask> cTask;
        int id = 0;
        boolean found = false;
//        String chk = "";

        ClientTaskServiceInternal tService = new ClientTaskServiceInternal();
        cTask = tService.getClientTasksByProductAndType(con, user, product, type);
        if (cTask.isEmpty())
        {
            throw new CommandException ("There are NO task(s) in ePO of type: " + type);
        }

        for (ClientTask task : cTask)
        {
//            chk = chk + task.getName() + "|";
            if (task.getName().equals(name))
            {
                id = task.getTaskObjectId();
                found = true;
                break;
            }
        }

        if (!found)
        {
            throw new CommandException ("There is NO task in ePO by name: " + name);
        }

        return id;

    }

    public static ClientTaskAssignment createTaskAssignment(int toId, int nodeId, int nodeType, int flag) throws Exception
    {
        ClientTaskAssignment ta = new ClientTaskAssignment();
        ta.setTaskObjectId(toId);
        ta.setNodeId(nodeId);
        ta.setNodeType(nodeType);
        ta.setTaskAssignmentFlag(flag);
        return ta;
    }    

    public ClientTaskAssignment save(Connection con, OrionUser user, ClientTaskAssignment ta, int id) throws Exception
    {
        TaskObjEventHelper.TaskObjSaveAssignmentNotify(ta, getEventDispatchService(), user.getId(),ta.getProductCode(), ta.getTaskType());
        return ta;
        
    }

    public static ClientTaskSlot createTaskSlot(Connection con, int typeId) throws Exception
    {
        TaskSlotDBDao tsDao = new TaskSlotDBDao(con);
        ClientTaskSlot ts = new ClientTaskSlot();
        ts.setTaskTypeId(typeId);
        tsDao.save(ts);
        con.commit();
        return ts;
    }    



    //-------------------------------------------------------------------------
    // Parameter getters/setters
    //-------------------------------------------------------------------------

    public void setComputer (String computer)
    {
        m_computer = computer;
    }

    public void setType (String type)
    {
        m_type = type;
    }

    public void setName (String name)
    {
        m_name = name;
    }

    public void setProduct (String product)
    {
        m_product = product;
    }

    public void setSettings (String settings)
    {
        m_settings = settings;
    }

    public void setParam1 (Object item)
    {
        setComputer (item.toString ());
    }

    public void setParam2 (Object item)
    {
        setType (item.toString ());
    }

    public void setParam3 (Object item)
    {
        setName (item.toString ());
    }

    public void setParam4 (Object item)
    {
        setProduct (item.toString ());
    }
    
    public void setParam5 (Object item)
    {
        setSettings (item.toString ());
    }

    public void setUser (OrionUser orionUser)
    {
        m_user = orionUser;
    }

    public OrionUser getUser ()
    {
        return m_user;
    }

    public Connection getConnection ()
    {
        return m_connection;
    }

    public void setConnection (Connection connection)
    {
        m_connection = connection;
    }

    public ClientTaskServiceInternal getClientTaskService ()
    {
        return m_clientTaskServices;
    }

    public void setClientTaskServiceInternal (ClientTaskServiceInternal clientTaskServices)
    {
        this.m_clientTaskServices = clientTaskServices;
    }

    public OrionEventDispatchService getEventDispatchService()
    {
        return eventDispatchService;
    }

    public void setEventDispatchService(OrionEventDispatchService eventDispatchService)
    {
        this.eventDispatchService = eventDispatchService;
    }
    
    //-------------------------------------------------------------------------
    // Private local variables
    //-------------------------------------------------------------------------

    private String m_settings;
    private String m_product;
    private String m_type;
    private String m_name;
    private String m_computer;

    private OrionUser m_user = null;
    private Connection m_connection = null;

    private ClientTaskType ctt;

    private List<EPOComputer> epoComputer = null;
    private ClientTaskServiceInternal m_clientTaskServices = null;
    private ClientTaskAssignment cTaskAssignment = null;
    private ClientTaskSlot slot = null;

    private int taskObjId = 0;
    private OrionEventDispatchService eventDispatchService = null;
}

