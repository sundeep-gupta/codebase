<?
   include("includes/header.php"); 
   $Auth->CheckRights(AUTH_LEVEL_VIEWER);
?>

<Script>
<!--
   function UpdateValue()
   {
      var subform=document.UpdatePorts;
      if (!confirm("Are you sure you wish to change the mode?")) {
         document.UpdatePorts.reset();
         return;
      }

      subform.submit();
   }
// -->
</Script>
<?   
   $Form = new HTML_PARAMETER_FORM();
   
   echo  $Form->Begin("accelerated_ports.php", "UpdateAccelPorts"),
         $Form->AddPortListParam("AcceleratedPorts"),
         HTML_FORM::AddSubmit("UpdateAccelPorts", "Update"),         
         $Form->End();
