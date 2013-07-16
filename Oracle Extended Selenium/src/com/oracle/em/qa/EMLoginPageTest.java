package com.oracle.em.qa;
import oracle.javatools.test.WebDriverBase;
import org.junit.Test;
import oracle.javatools.test.WebDriverRunner.UseViewDeclarationLanguages;
import oracle.javatools.test.WebDriverRunner.VDL;
@UseViewDeclarationLanguages( {VDL.Facelets}

)
/* How to solve
 * org.openqa.selenium.WebDriverException: Unable to bind to locking port 7054 within 45000 ms
 */
public class EMLoginPageTest extends WebDriverBase {
   
   // public static final String APP_ROOT="Application1-ViewController-context-root/";
    public static final String APP_ROOT="em/faces/";
    public String getAppRoot() {       
        return APP_ROOT;
    }
 
    @Test
    public void emLogInout() {       
        emLogin();        
       emLogout();        
    }


    public void emLogin(){
      try {       
         setHttpProtocol("https://");   
         startupTest("logon", "");       
         sendKeys("rich=j_username#content","sysman");       
         sendKeys("rich=j_password#content","sysman");        
         click("rich=login");
        }catch(Exception ex) {            
         ex.printStackTrace();           
         System.out.println("Exception found:" + ex.getMessage());
        }

    }  
   
    public void emLogout(){
        try {            
           click("rich=emT:file_log_out");      
        }catch(Exception ex) {  
           ex.printStackTrace();     
           System.out.println("Exception found:" + ex.getMessage()); 
        }                   
    }

}
   