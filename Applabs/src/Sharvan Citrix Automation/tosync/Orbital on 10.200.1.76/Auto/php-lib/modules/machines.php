<?php

######################################################################################
#
# Copyright:     Key Labs, 2005
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision: 1.2 $
# Last Modified: $Date: 2005/09/30 20:44:12 $
# Modified By:   $Author: jason $
# Source:        $Source: /cvsroot/orbitaldata/control/php-lib/modules/machines.php,v $
#
######################################################################################



class machines {


    function machines() {
    	// Object constructor
    }

    //
    // getMachineGroups() - Get a detailed list of all machine groups and the machines in them
    // Input:  $db - Database object
    // Output: Associative array containing machine group details
    function getMachineGroups($db, $SortBy, $Direction) {
        if (empty($SortBy)) {
            $SortBy = "Name";
        }
        if (empty($Direction)) {
            $Direction = "ASC";
        }

        $results = $db->get_results("SELECT mg.MachineGroupID, mg.Name, mg.Description, '' AS machines
                                     FROM machinegroups mg ORDER BY mg.$SortBy $Direction");

        // Iterate through each machine group and get all machines associated with it
        foreach ($results as $group) {
            $machines = $db->get_results("SELECT m.Name AS name, m.IPaddress AS ip_address, m.MachineType, m.OS AS os, m.UserID AS user, m.Passw AS password, m.Active
                                          FROM machines m
                                          INNER JOIN machinegroups_machines mgm USING (MachineID)
                                          INNER JOIN machinegroups mg USING (MachineGroupID)
                                          WHERE mg.MachineGroupID = '".$group->MachineGroupID."' 
                                          ORDER BY m.MachineType, m.Name");

            $group->{'machines'} = $machines;
        }
        
        return ($results) ? $results : false;
    }

    //
    // addMachineGroup() - Add a new machine group to the database (set of clients/servers/orbitals/wansim)
    // Input:  $db          - Database object
    //         $machineList - Array containing list of all machine ID's for the group to be created
    //         $Name        - Name of machine group
    //         $Description - Description of machine group
    // Output: Returns the last insert id for the machine group created. False otherwise
    function addMachineGroup($db, $machineList, $Name, $Description) {
        $row = $db->get_row("SELECT * FROM machinegroups WHERE Name = '$Name'");
        
        // If a record already exists with the same machine group name, return false
        if (isset($row)) {
            return false;
        }
        
        // Create new machine group
        $db->query("INSERT INTO machinegroups SET
                        Name        = '$Name',
                        Description = '$Description'");
        if (empty($db->insert_id)) {
            return false;
        }
        
        $MachineGroupID = $db->insert_id;
        
        // Insert all machines into the new group
        foreach ($machineList as $MachineID) {
            $db->query("INSERT INTO machinegroups_machines SET
                            MachineGroupID = '$MachineGroupID',
                            MachineID      = '$MachineID'");
        }
        
        return $MachineGroupID;
    }

    //
    // editMachineGroup() - Edit the given machine group in the database (set of clients/servers/orbitals/wansim)
    // Input:  $db             - Database object
    //         $MachineGroupID - Machine group id
    //         $machineList    - Array containing list of all machine ID's for the group to be created
    //         $Name           - Name of machine group
    //         $Description    - Description of machine group
    // Output: Returns true on success or false on failure
    function editMachineGroup($db, $MachineGroupID, $machineList, $Name, $Description) {
        $row = $db->get_row("SELECT * FROM machinegroups WHERE MachineGroupID = '$MachineGroupID'");
        
        // Make sure a record exists or return false
        if (empty($row)) {
            return false;
        }
        
        // Fetch our machines to archive
        $archiveMachines = $db->get_results("SELECT MachineID FROM machinegroups_machines WHERE MachineGroupID = '$MachineGroupID'");

        // Make sure we have a list of machines
        if (empty($archiveMachines)) {
            return false;
        }

        // Next archive our original data
        $this->archiveMachineGroup($db, $row->MachineGroupID, $archiveMachines, $row->Name, $row->Description, time());
        
        // Edit our machine group
        $retval = $db->query("UPDATE machinegroups SET
                                  Name        = '$Name',
                                  Description = '$Description',
                                  Modified    = '1'
                              WHERE MachineGroupID = '$MachineGroupID'");
        
        // Edit all machines in the group
        $machine_count = 0;
        foreach ($machineList as $MachineID) {
            // Check if the machine we want to add already exists in the database
            $machine_exists = false;
            for ($i=0; $i <= sizeof($archiveMachines); $i++) {
                if ($MachineID == $archiveMachines[$i]->MachineID) {
                    // If the machine does exist, we dump it out of our "delete" list
                    array_splice($archiveMachines, $i, 1);
                    $machine_exists = true;
                    break;
                }
            }
            
            // If the machine doesn't exist, add it to our group
            if ($machine_exists == false) {
                $retval = $this->addMachineToGroup($db, $MachineGroupID, $MachineID);
            }
            $machine_count++;
        }
        
        // Finally, delete the machines that have not been selected
        foreach ($archiveMachines as $deleteMachineID) {
            $retval = $this->deleteMachineFromGroup($db, $MachineGroupID, $deleteMachineID->MachineID);
        }

        return ($machine_count == sizeof($machineList)) ? $machine_count : false;
    }

    //
    // archiveMachineGroup() - Archive a machine group in the database (set of clients/servers/orbitals/wansim)
    // Input:  $db             - Database object
    //         $MachineGroupID - Machine group id
    //         $machineList    - Array containing list of all machine ID's for the group to be created
    //         $Name           - Name of machine group
    //         $Description    - Description of machine group
    //         $Timestamp      - Unix timestamp
    // Output: Returns true on success or false on failure
    function archiveMachineGroup($db, $MachineGroupID, $machineList, $Name, $Description, $Timestamp) {

        // Create new archive record
        $db->query("INSERT INTO archive_machinegroups SET
                        MachineGroupID = '$MachineGroupID',
                        Name           = '$Name',
                        Description    = '$Description',
                        Timestamp      = '$Timestamp'");
        
        // Insert all machines into the archive group
        foreach ($machineList as $machine) {
            $db->query("INSERT INTO archive_machinegroups_machines SET
                            MachineGroupID = '$MachineGroupID',
                            MachineID      = '".$machine->MachineID."',
                            Timestamp      = '$Timestamp'");
        }

        return (isset($db->num_rows)) ? true : false;
    }

    //
    // getMachineGroupDetails() - Get detailed information a machine group using the given machine group id
    // Input:  $db             - Database object
    //         $MachineGroupID - Machine group id
    // Output: Returns an associative array containing the machine group details
    function getMachineGroupDetails($db, $MachineGroupID) {
        $row = $db->get_row("SELECT MachineGroupID, Name, Description, '' AS clients, '' AS servers, '' AS orbitals, '' AS wansim
                             FROM machinegroups 
                             WHERE MachineGroupID = '$MachineGroupID'");
        
        // Make sure we returned some results
        if (empty($row)) {
            return false;
        }
        
        $row->clients  = $this->getClientGroup($db, $MachineGroupID);
        $row->servers  = $this->getServerGroup($db, $MachineGroupID);
        $row->orbitals = $this->getOrbitalGroup($db, $MachineGroupID);
        $row->wansim   = $this->getWanSimGroup($db, $MachineGroupID);
        
        return ($row) ? $row : false;
    }

    //
    // addMachineToGroup() - Add a machine to the specified machine group
    // Input:  $db             - Database object
    //         $MachineGroupID - Machine group id
    //         $MachineID      - Machine id value
    // Output: Returns true on success or false on failure
    function addMachineToGroup($db, $MachineGroupID, $MachineID) {
        
        $db->query("INSERT INTO machinegroups_machines SET
                        MachineGroupID = '$MachineGroupID',
                        MachineID      = '$MachineID'");
        
        return (isset($db->rows_affected)) ? true : false;
    }

    //
    // deleteMachineFromGroup() - Delete a machine from the machine group specified
    // Input:  $db             - Database object
    //         $MachineGroupID - Machine group id
    //         $MachineID      - Machine id value
    // Output: Returns true on success or false on failure
    function deleteMachineFromGroup($db, $MachineGroupID, $MachineID) {
        
        $db->query("DELETE FROM machinegroups_machines
                    WHERE MachineGroupID = '$MachineGroupID' AND MachineID = '$MachineID'");
        
        return (isset($db->rows_affected)) ? true : false;
    }

    //
    // getMachineTypes() - Get a list of all the machine types
    // Input:  $db - Database object
    // Output: Returns a list of all the machine types available
    function getMachineTypes($db) {
        $row = $db->query("SHOW COLUMNS FROM machines LIKE 'MachineType'");

        // Get the second row from the cached results by using a null query
        $row_details = $db->get_row(null, ARRAY_A, 0);

        // Fetch the enum values for the field
        $values = explode("','", preg_replace("/(enum|set)\('(.+?)'\)/", "\\2", $row_details['Type']));

        return $values;
    }

    //
    // getMachineOS() - Get a list of all the machine operating systems
    // Input:  $db - Database object
    // Output: Returns a list of all the machine operating systems
    function getMachineOS($db) {
        $row = $db->query("SHOW COLUMNS FROM machines LIKE 'OS'");

        // Get the second row from the cached results by using a null query
        $row_details = $db->get_row(null, ARRAY_A, 0);

        // Fetch the enum values for the field
        $values = explode("','", preg_replace("/(enum|set)\('(.+?)'\)/", "\\2", $row_details['Type']));

        return $values;
    }

    //
    // addMachine() - Add a new machine to the database 
    // Input:  $db             - Database object
    //         $Name           - Name of the machine
    //         $MachineType    - Type of machine (client/server/orbital/wansim)
    //         $IPaddress      - IP address of the machine
    //         $OS             - Operating system of the machine
    //         $UserID         - User name of the machine
    //         $Passw          - Password of the user
    //         $Active         - Active status of the machine. (1=on, 0=off)
    //         $ProxyIPaddress - If the machine needs to use a proxy IP address, set it here
    //         $ProxyPort      - Port number of the proxy
    // Output: Returns the last insert id of the machine. False otherwise
    function addMachine($db, $Name, $MachineType, $IPaddress, $OS, $UserID, $Passw, $Active, $ProxyIPaddress='', $ProxyPort='') {
        $row = $db->get_row("SELECT * FROM machines
                             WHERE Name = '$Name' AND
                                MachineType = '$MachineType' AND
                                IPaddress   = '$IPaddress' AND
                                OS          = '$OS'");
        
        // If a record already exists with the same test case data, return false
        if (isset($row)) {
            return false;
        }
        
        $db->query("INSERT INTO machines SET
                        Name           = '$Name',
                        MachineType    = '$MachineType',
                        IPaddress      = '$IPaddress',
                        ProxyIPaddress = '$ProxyIPaddress',
                        ProxyPort      = '$ProxyPort',
                        OS             = '$OS',
                        UserID         = '$UserID',
                        Passw          = '$Passw',
                        Active         = '$Active'");
        
        return (isset($db->insert_id)) ? $db->insert_id : false;
    }
    
    //
    // editMachine() - Edit a machine's information 
    // Input:  $db             - Database object
    //         $MachineID      - Machine id value
    //         $Name           - Name of the machine
    //         $MachineType    - Type of machine (client/server/orbital/wansim)
    //         $IPaddress      - IP address of the machine
    //         $OS             - Operating system of the machine
    //         $UserID         - User name of the machine
    //         $Passw          - Password of the user
    //         $Active         - Active status of the machine. (1=on, 0=off)
    //         $ProxyIPaddress - If the machine needs to use a proxy IP address, set it here
    //         $ProxyPort      - Port number of the proxy
    // Output: Returns true on success, false otherwise
    function editMachine($db, $MachineID, $Name, $MachineType, $IPaddress, $OS, $UserID, $Passw, $Active, $ProxyIPaddress='', $ProxyPort='') {
        $row = $db->get_row("SELECT * FROM machines
                             WHERE MachineID = '$MachineID'");
        
        // Make sure a record exists otherwise, return false
        if (empty($row)) {
            return false;
        }
        
        // Next, let's archive the original data
        $this->archiveMachine($db, $row->MachineID, $row->Name, $row->MachineType, $row->IPaddress, $row->OS, $row->UserID, $row->Passw, $row->Active, $row->ProxyIPaddress, $row->ProxyPort, time());
        
        // Finally, let's edit the data
        $retval = $db->query("UPDATE machines SET
                                  Name           = '$Name',
                                  MachineType    = '$MachineType',
                                  IPaddress      = '$IPaddress',
                                  ProxyIPaddress = '$ProxyIPaddress',
                                  ProxyPort      = '$ProxyPort',
                                  OS             = '$OS',
                                  UserID         = '$UserID',
                                  Passw          = '$Passw',
                                  Active         = '$Active',
                                  Modified       = '1'
                              WHERE MachineID    = '$MachineID'");
        
        return ($retval) ? true : false;
    }

    //
    // archiveMachine() - Archive the given machine data
    // Input:  $db          - Database object
    //         $MachineID   - Machine id value
    //         $Name        - Name of the machine
    //         $MachineType - Type of machine (client/server/orbital/wansim)
    //         $IPaddress   - IP address of the machine
    //         $OS          - Operating system of the machine
    //         $UserID      - User name of the machine
    //         $Passw       - Password of the user
    //         $Active      - Active status of the machine. (1=on, 0=off)
    //         $Timestamp   - Timestamp to place on archived item
    // Output: Returns the last insert id of the machine. False otherwise
    function archiveMachine($db, $MachineID, $Name, $MachineType, $IPaddress, $OS, $UserID, $Passw, $Active, $ProxyIPaddress='', $ProxyPort='', $Timestamp) {

        $db->query("INSERT INTO archive_machines SET
                        MachineID      = '$MachineID',
                        Name           = '$Name',
                        MachineType    = '$MachineType',
                        IPaddress      = '$IPaddress',
                        ProxyIPaddress = '$ProxyIPaddress',
                        ProxyPort      = '$ProxyPort',
                        OS             = '$OS',
                        UserID         = '$UserID',
                        Passw          = '$Passw',
                        Active         = '$Active',
                        Timestamp      = '$Timestamp'");

        return (isset($db->rows_affected)) ? $db->rows_affected : false;
    }
    
    //
    // getComputers() - Get a detailed list of all computers, clients and servers
    // Input:  $db - Database object
    // Output: Associative array containing computer details
    function getComputers($db, $SortBy, $Direction) {
        if (empty($SortBy)) {
            $SortBy = "MachineType";
        }
        if (empty($Direction)) {
            $Direction = "ASC";
        }
        $results = $db->get_results("SELECT m.MachineID, m.Name AS name, m.IPaddress AS ip_address, m.OS AS os, m.UserID AS user, m.Passw AS password, m.MachineType, m.Active, m.ProxyIPaddress, m.ProxyPort
                                     FROM machines m
                                     WHERE (m.MachineType = 'client' OR m.MachineType = 'server')
                                     ORDER BY m.$SortBy $Direction");

        return ($results) ? $results : false;
    }

    //
    // getComputerDetails() - Get detailed information on a specific computer (client or server)
    // Input:  $db        - Database object
    //         $MachineID - Machine id value
    // Output: Associative array containing computer details
    function getComputerDetails($db, $MachineID) {
        $row = $db->get_row("SELECT m.MachineID, m.Name AS name, m.IPaddress AS ip_address, m.OS AS os, m.UserID AS user, m.Passw AS password, m.MachineType, m.Active, m.ProxyIPaddress, m.ProxyPort
                             FROM machines m
                             WHERE (m.MachineType = 'client' OR m.MachineType = 'server') AND
                             m.MachineID = '$MachineID'");

        return ($row) ? $row : false;
    }
    
    //
    // getClients() - Get a detailed list of all client computers
    // Input:  $db - Database object
    // Output: Associative array containing computer details
    function getClients($db) {
        $results = $db->get_results("SELECT m.MachineID, m.Name AS name, m.IPaddress AS ip_address, m.OS AS os, m.UserID AS user, m.Passw AS password, m.MachineType, m.Active, m.ProxyIPaddress, m.ProxyPort
                                     FROM machines m
                                     WHERE m.MachineType = 'client'
                                     ORDER BY m.MachineType");

        return ($results) ? $results : false;
    }
    
    //
    // getClientGroup() - Get a list of clients associated with a particular machine group
    // Input:  $db             - Database object
    //         $MachineGroupID - Machine group id
    // Output: Associative array containing a list of client machines associated with a given machine group
    function getClientGroup($db, $MachineGroupID) {
        $results = $db->get_results("SELECT mg.MachineGroupID, m.MachineID, m.Name AS name, m.IPaddress AS ip_address, m.OS AS os, m.UserID AS user, m.Passw AS password, m.MachineType, m.Active, m.ProxyIPaddress, m.ProxyPort
                                     FROM machinegroups mg
                                     INNER JOIN machinegroups_machines USING (MachineGroupID)
                                     INNER JOIN machines m USING (MachineID)
                                     WHERE m.MachineType = 'client' AND
                                         mg.MachineGroupID = '$MachineGroupID'");
        
        return ($results) ? $results : false;
    }

    //
    // getServers() - Get a detailed list of all server computers
    // Input:  $db - Database object
    // Output: Associative array containing computer details
    function getServers($db) {
        $results = $db->get_results("SELECT m.MachineID, m.Name AS name, m.IPaddress AS ip_address, m.OS AS os, m.UserID AS user, m.Passw AS password, m.MachineType, m.Active, m.ProxyIPaddress, m.ProxyPort
                                     FROM machines m
                                     WHERE m.MachineType = 'server'
                                     ORDER BY m.MachineType");

        return ($results) ? $results : false;
    }

    //
    // getServerGroup() - Get a list of servers associated with a particular machine group
    // Input:  $db             - Database object
    //         $MachineGroupID - Machine group id
    // Output: Associative array containing a list of server machines associated with a given machine group
    function getServerGroup($db, $MachineGroupID) {
        $results = $db->get_results("SELECT mg.MachineGroupID, m.MachineID, m.Name AS name, m.IPaddress AS ip_address, m.OS AS os, m.UserID AS user, m.Passw AS password, m.MachineType, m.Active, m.ProxyIPaddress, m.ProxyPort
                                     FROM machinegroups mg
                                     INNER JOIN machinegroups_machines USING (MachineGroupID)
                                     INNER JOIN machines m USING (MachineID)
                                     WHERE m.MachineType = 'server' AND
                                         mg.MachineGroupID = '$MachineGroupID'");
        
        return ($results) ? $results : false;
    }

    //
    // getOrbitals() - Get a detailed list of all Orbital devices
    // Input:  $db - Database orbject
    // Output: Associative array containing Orbital device details
    function getOrbitals($db, $SortBy, $Direction) {
        if (empty($SortBy)) {
            $SortBy = "Name";
        }
        if (empty($Direction)) {
            $Direction = "ASC";
        }

        $results = $db->get_results("SELECT m.MachineID, m.Name AS name, m.IPaddress AS ip_address, m.OS AS os, m.UserID AS user, m.Passw AS password, m.MachineType, m.Active
                                     FROM machines m
                                     WHERE m.MachineType = 'orbital'
                                     ORDER BY m.$SortBy $Direction");
        
        return ($results) ? $results : false;
    }

    //
    // getOrbitalDetails() - Get detailed information on a specific Orbital device
    // Input:  $db        - Database object
    //         $MachineID - Machine id value
    // Output: Associative array containing Orbital device details
    function getOrbitalDetails($db, $MachineID) {
        $row = $db->get_row("SELECT m.MachineID, m.Name AS name, m.IPaddress AS ip_address, m.OS AS os, m.UserID AS user, m.Passw AS password, m.MachineType, m.Active
                             FROM machines m
                             WHERE m.MachineType = 'orbital' AND
                             m.MachineID = '$MachineID'");
        
        return ($row) ? $row : false;
    }
    
    //
    // getOrbitalGroup() - Get a list of Orbitals associated with a particular machine group
    // Input:  $db             - Database object
    //         $MachineGroupID - Machine group id
    // Output: Associative array containing a list of Orbital machines associated with a given machine group
    function getOrbitalGroup($db, $MachineGroupID) {
        $results = $db->get_results("SELECT mg.MachineGroupID, m.MachineID, m.Name AS name, m.IPaddress AS ip_address, m.OS AS os, m.UserID AS user, m.Passw AS password, m.MachineType, m.Active
                                     FROM machinegroups mg
                                     INNER JOIN machinegroups_machines USING (MachineGroupID)
                                     INNER JOIN machines m USING (MachineID)
                                     WHERE m.MachineType = 'orbital' AND
                                         mg.MachineGroupID = '$MachineGroupID'");
        
        return ($results) ? $results : false;
    }

    //
    // getWanSims() - Get a detailed list of all WAN simulators
    // Input:  $db - Database object
    // Output: Associative array containing WAN simulator details
    function getWanSims($db, $SortBy, $Direction) {
        if (empty($SortBy)) {
            $SortBy = "Name";
        }
        if (empty($Direction)) {
            $Direction = "ASC";
        }
        $results = $db->get_results("SELECT m.MachineID, m.Name AS name, m.IPaddress AS ip_address, m.OS AS os, m.UserID AS user, m.Passw AS password, m.MachineType, m.Active
                                     FROM machines m
                                     WHERE m.MachineType = 'delayrouter'
                                     ORDER BY m.$SortBy");
        
        return ($results) ? $results : false;
    }
    
    //
    // getWanSimDetails() - Get detailed information on a specific WAN simulator
    // Input:  $db        - Database object
    //         $MachineID - Machine id value
    // Output: Associative array containing WAN simulator details
    function getWanSimDetails($db, $MachineID) {
        $row = $db->get_row("SELECT m.MachineID, m.Name AS name, m.IPaddress AS ip_address, m.OS AS os, m.UserID AS user, m.Passw AS password, m.MachineType, m.Active
                             FROM machines m
                             WHERE m.MachineType = 'delayrouter' AND
                             m.MachineID = '$MachineID'");
        
        return ($row) ? $row : false;
    }

    //
    // getWanSimGroup() - Get a list of WAN-simulators associated with a particular machine group
    // Input:  $db             - Database object
    //         $MachineGroupID - Machine group id
    // Output: Associative array containing a list of WAN-simulators associated with a given machine group
    function getWanSimGroup($db, $MachineGroupID) {
        $results = $db->get_results("SELECT mg.MachineGroupID, m.MachineID, m.Name AS name, m.IPaddress AS ip_address, m.OS AS os, m.UserID AS user, m.Passw AS password, m.MachineType, m.Active
                                     FROM machinegroups mg
                                     INNER JOIN machinegroups_machines USING (MachineGroupID)
                                     INNER JOIN machines m USING (MachineID)
                                     WHERE m.MachineType = 'delayrouter' AND
                                         mg.MachineGroupID = '$MachineGroupID'");
        
        return ($results) ? $results : false;
    }


}

    $myMachines = &new machines();

?>
