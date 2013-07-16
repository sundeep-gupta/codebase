Assuming you are able to return the image into a recordset with something like:

String query = "select image from images where id =1";        
Statement st = con.createStatement();
ResultSet rs = st.executeQuery(query);
rs.next();

The code youre really after goes something like this:


byte[] bytearray = new byte[4096];
int size=0;
InputStream sImage; 
sImage = rs.getBinaryStream(1);
response.reset();
response.setContentType("image/jpeg");
response.addHeader("Content-Disposition","filename=getimage.jpeg");
while((size=sImage.read(bytearray))!= -1 ) 
    {
        response.getOutputStream().write(bytearray,0,size);
    }
    
        response.flushBuffer();
sImage.close();

The problem with this is that you cannot put it into a table etc. The original poster of the solution in the Sun forum 'included' the jsp containing the above in the table of a second jsp, which is what I do also.

