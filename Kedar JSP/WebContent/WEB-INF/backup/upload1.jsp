<form name="uploadForm" action="upload.jsp" enctype="multipart/form-data" method="post">
  <input type="file" name="file"/>
  <input TYPE=Button name='Upload' Value='Upload' onClick="uploadForm.Upload.value='Uploading...';document.uploadForm.action='upload.jsp';document.uploadForm.submit()">
</form>

