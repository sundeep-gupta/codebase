<%! //   Filename: Default.jsp
    static final String sFileName = "Default.jsp";
%><%

boolean bDebug = false;

String sAction = getParam( request, "FormAction");
String sForm = getParam( request, "FormName");
String sSearchErr = "";
String sAdvMenuErr = "";
String sRecommendedErr = "";
String sWhatErr = "";
String sCategoriesErr = "";
String sNewErr = "";
String sWeeklyErr = "";
String sSpecialsErr = "";

java.sql.Connection conn = null;
java.sql.Statement stat = null;
String sErr = loadDriver();
conn = cn();
stat = conn.createStatement();
if ( ! sErr.equals("") ) {
 try {
   out.println(sErr);
 }
 catch (Exception e) {}
}

%>            
<html>
    <head>
        <title>Book Store</title>
        <meta name="GENERATOR" content="YesSoftware CodeCharge v.1.2.0 / JSP.ccp build 05/21/2001"/>
        <meta http-equiv="pragma" content="no-cache"/>
        <meta http-equiv="expires" content="0"/>
        <meta http-equiv="cache-control" content="no-cache"/>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
    </head>
    <body style="background-color: #FFFFFF; color: #000000; font-family: Arial, Tahoma, Verdana, Helveticabackground-color: #FFFFFF; color: #000000; font-family: Arial, Tahoma, Verdana, Helvetica">
    <%-- Include Page Header here... --%>
    <jsp:include page="Header.jsp" flush="true"/>
     <table>
        <tr>
        <td valign="top">
            <table>
                <form method="get" action="Books.jsp" name="Search">
                <tr><td style="background-color: #336699; text-align: Center; border-style: outset; border-width: 1" colspan="5">
                      <font style="font-size: 12pt; color: #FFFFFF; font-weight: bold">Search</font>
                </td></tr>
                <tr><td style="background-color: #FFEAC5; border-style: inset; border-width: 0">
                    <font style="font-size: 10pt; color: #000000">Category</font>
                    </td>
                    <td style="background-color: #FFFFFF; border-width: 1">
                        <select name="category_id">
                            <%= getOptions( conn, "select category_id, name from categories order by 2",true,false,fldcategory_id)  %>
                        </select>
                    </td>
                </tr>
                <tr><td style="background-color: #FFEAC5; border-style: inset; border-width: 0">
                        <font style="font-size: 10pt; color: #000000">Title</font>
                    </td>
                    <%
                        fldcategory_id = request.getParameter("category_id");
                        fldname     = request.getParameter("name");
                    %>
                    <td style="background-color: #FFFFFF; border-width: 1">
                          <input type="text"  name="name" maxlength="10" value="" size="10">
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="3">
                        <input type="submit" value="Search"/>
                    </td>
                </tr>
                </form>
            </table>
        </td></tr><tr>
        <td>
            <table>
                <tr><td colspan="1"  style="background-color: #336699; text-align: Center; border-style: outset; border-width: 1">
                        <font style="font-size: 12pt; color: #FFFFFF; font-weight: bold">More Search Options</font>
                    </td>
                </tr>
                <tr><td style="background-color: #FFFFFF; border-width: 1">
                    <a href="AdvSearch.jsp">
                        <font style="font-size: 10pt; color: #000000">Advanced search</font>
                    </a></td>
                </tr>
            </table>
        </td></tr><tr>
        <td>
            <table>
                <tr><td style="background-color: #336699; text-align: Center; border-style: outset; border-width: 1" colspan="1">
                    <font style="font-size: 12pt; color: #FFFFFF; font-weight: bold">Categories</font>
                </td></tr> 
                <tr><td colspan="1" style="background-color: #FFFFFF; border-width: 1">
                    <font style="font-size: 10pt; color: #000000">No records</font>
                </td></tr>
                <tr><td colspan="1" style="background-color: #FFFFFF; border-style: inset; border-width: 0">
                    <font style="font-size: 10pt; color: #CE7E00; font-weight: bold"></font>
                </td></tr>

   <%
   try {
       java.sql.ResultSet rs = null;
       // Open recordset
       rs = openrs( stat, sSQL);
       iCounter = 0;
     
       java.util.Hashtable rsHash = new java.util.Hashtable();
       String[] aFields = getFieldsName( rs );

    // Show main table based on recordset
        while ( rs.next() ) {
           getRecordToHash( rs, rsHash, aFields );
           String fldname = (String) rsHash.get("c_name");
   %>
                <tr><td style="background-color: #FFFFFF; border-width: 1">
                    <a href="Books.jsp?&category_id=<%= toURL((String) rsHash.get("c_category_id"))%>">
                        <font style="font-size: 10pt; color: #000000"> <%= toHTML(fldname) %> </font>
                    </a></td>
                </tr>
/ ------------------------------------------------------------------------------------------------------------------------------------------
<%
          iCounter++;
        }
        rs.close();
        if (iCounter == 0) {
              iCounter = RecordsPerPage+1;
              bIsScroll = false;
        }   
  }  catch (Exception e) { out.println(e.toString());
  %>
              </table>
        </td></tr><tr>
        <td>
        <table>
            <tr><td style="background-color: #336699; text-align: Center; border-style: outset; border-width: 1" colspan="1">
                <a name=\"Specials\">
                    <font style="font-size: 12pt; color: #FFFFFF; font-weight: bold">Weekly Specials</font>
                </a></td>
            </tr>
<%                
  try {
    java.sql.ResultSet rs = null;
    // Open recordset
    rs = openrs( stat, "select e.article_desc as e_article_desc, e.article_title as e_article_title from editorials e WHERE editorial_cat_id=4 ");
    iCounter = 0;
    
    java.util.Hashtable rsHash = new java.util.Hashtable();
    String[] aFields = getFieldsName( rs );

    // Show main table based on recordset
    while ( rs.next() ) {

      getRecordToHash( rs, rsHash, aFields );
      String fldarticle_desc = (String) rsHash.get("e_article_desc");
      String fldarticle_title = (String) rsHash.get("e_article_title");
%>
            <tr><td style="background-color: #FFFFFF; border-style: inset; border-width: 0">
                <font style="font-size: 10pt; color: #CE7E00; font-weight: bold"></font> 
            </td></tr>
            <tr><td style="background-color: #FFFFFF; border-width: 1">
                <font style="font-size: 10pt; color: #000000"><%= fldarticle_title %>&nbsp;</font>
            </td></tr>
            <tr><td style="background-color: #FFFFFF; border-style: inset; border-width: 0">
                <font style="font-size: 10pt; color: #CE7E00; font-weight: bold"></font> 
            </td></tr>
            <tr><td style="background-color: #FFFFFF; border-width: 1">
                <font style="font-size: 10pt; color: #000000"><%=fldarticle_desc %>&nbsp;</font>
            </td></tr>
   <%
      iCounter++;
    }
    rs.close();
    if (iCounter == 0) {
      // Recordset is empty
      out.println(sNoRecords);
      iCounter = RecordsPerPage+1;
      bIsScroll = false;
    } 
    
    
    
  }
  catch (Exception e) { out.println(e.toString()); }
   %>
        </table>
        </td>
        <td valign="top">
        
<%
    String sWhere = "";
    int iCounter=0;
    int iPage = 0;
    boolean bIsScroll = true;
    boolean hasParam = false;
    String sOrder = "";
    String sSQL="";
    String transitParams = "";
    String sQueryString = "";
    String sPage = "";
    int RecordsPerPage = 20;
    String sSortParams = "";
    String formParams = "";


 
    // Build WHERE statement
        
    sWhere = " WHERE is_recommended=1";
    // Build ORDER statement
    String sSort = getParam( request, "FormRecommended_Sorting");
    String sSorted = getParam( request, "FormRecommended_Sorted");
    String sDirection = "";
    String sForm_Sorting = "";
    int iSort = 0;
    try {
      iSort = Integer.parseInt(sSort);
    } catch (NumberFormatException e ) {
      sSort = "";
    }
    if ( iSort == 0 ) {
      sForm_Sorting = "";
    }  else {
        if ( sSort.equals(sSorted)) { 
            sSorted="0";
            sForm_Sorting = "";
            sDirection = " DESC";
            sSortParams = "FormRecommended_Sorting=" + sSort + "&FormRecommended_Sorted=" + sSort + "&";
        } else {
            sSorted=sSort;
            sForm_Sorting = sSort;
            sDirection = " ASC";
            sSortParams = "FormRecommended_Sorting=" + sSort + "&FormRecommended_Sorted=" + "&";
        }
        if ( iSort == 1) { sOrder = " order by i.name" + sDirection; }
        if ( iSort == 2) { sOrder = " order by i.author" + sDirection; }
        if ( iSort == 3) { sOrder = " order by i.image_url" + sDirection; }
        if ( iSort == 4) { sOrder = " order by i.price" + sDirection; }
    }
  // Build full SQL statement
  
    sSQL = "select i.author as i_author, i.image_url as i_image_url, i.item_id as i_item_id, " +
                    "i.name as i_name, i.price as i_price from items i " + sWhere + sOrder;

    String sNoRecords = " <tr><td colspan=\"1\" style=\"background-color: #FFFFFF; border-width: 1\"><font style=\"font-size: 10pt; color: #000000\">No records</font></td>\n     </tr>";
 
    try {
    // Select current page
        iPage = Integer.parseInt(getParam( request, "FormRecommended_Page"));
    } catch (NumberFormatException e ) {
        iPage = 0;
    }

    if (iPage == 0) {
        iPage = 1;
    }
    RecordsPerPage = 5;
    try {
        java.sql.ResultSet rs = null;
        // Open recordset
        rs = openrs( stat, sSQL);
        iCounter = 0;
        absolute (rs, (iPage-1)*RecordsPerPage+1);
        java.util.Hashtable rsHash = new java.util.Hashtable();
        String[] aFields = getFieldsName( rs );

        // Show main table based on recordset
        while ( (iCounter < RecordsPerPage) && rs.next() ) {

            getRecordToHash( rs, rsHash, aFields );
            String fldauthor = (String) rsHash.get("i_author");
            String fldimage_url = (String) rsHash.get("i_image_url");
            String fldname = (String) rsHash.get("i_name");
            String fldprice = (String) rsHash.get("i_price");
            fldimage_url="<img border=0 src=" + fldimage_url + ">";
        %>     
        <tr><td style="background-color: #FFFFFF; border-style: inset; border-width: 0">
            <font style="font-size: 10pt; color: #CE7E00; font-weight: bold"></font>
        </td></tr>
        <tr><td style="background-color: #FFFFFF; border-width: 1">
            <a href="BookDetail.jsp?item_id="<%=toURL((String) rsHash.get("i_item_id"))%>" >
                <font style="font-size: 10pt; color: #000000"><%= toHTML(fldname) %></font>
            </a>
        </td></tr>
        <tr><td style="background-color: #FFFFFF; border-style: inset; border-width: 0">
            <font style="font-size: 10pt; color: #CE7E00; font-weight: bold"></font>
        </td></tr>
        <tr><td style="background-color: #FFFFFF; border-width: 1">
            <font style="font-size: 10pt; color: #000000"><<%= toHTML(fldauthor) %></font>
        </td></tr>
        <tr><td style="background-color: #FFFFFF; border-style: inset; border-width: 0">
            <font style="font-size: 10pt; color: #CE7E00; font-weight: bold"></font>
        </td></tr>
        <tr><td style="background-color: #FFFFFF; border-width: 1">
            <a href="BookDetail.jsp?item_id="<%= toURL((String) rsHash.get("i_item_id")) %>">
                <font style="font-size: 10pt; color: #000000"><%= fldimage_url %></font>
            </a>
        </td></tr>
        <tr><td style="background-color: #FFFFFF; border-style: inset; border-width: 0">
            <font style="font-size: 10pt; color: #CE7E00; font-weight: bold"><%= Price %></font>
        </td></tr>
        <tr><td style="background-color: #FFFFFF; border-width: 1"> 
            <font style="font-size: 10pt; color: #000000"><%= toHTML(fldprice) %></font>
        </td></tr>
        <tr><td colspan="2" style="background-color: #FFFFFF; border-width: 1">&nbsp;</td></tr>
        <%
          iCounter++;
        }

        if (iCounter == 0) {
            // Recordset is empty
            out.println(sNoRecords);
            iCounter = RecordsPerPage+1;
            bIsScroll = false;
        } else {
            // Parse scroller
            boolean bInsert = false;
            boolean bNext = rs.next();
            if ( !bNext && iPage == 1 ) {

        } else { %>
                 <tr><td colspan="1" style="background-color: #FFFFFF; border-style: inset; border-width: 0">
                        <font style="font-size: 10pt; color: #CE7E00; font-weight: bold">
        <%
            if ( iPage == 1 ) { %>
                <a href_="#"><font style="font-size: 10pt; color: #CE7E00; font-weight: bold">Previous</font></a>
        <%  } else { %>
                <a href="<%= sFileName %>?<%= formParams+sSortParams %>&FormRecommended_Page=<%= (iPage - 1) %>#Form">
                    <font style="font-size: 10pt; color: #CE7E00; font-weight: bold">Previous</font>
                </a>
        <%  } %>

            <%= " "+iPage %>

        <%  if (!bNext) { %>
                <a href_="#">
                    <font style="font-size: 10pt; color: #CE7E00; font-weight: bold">Next</font>
                </a><br>
        <%  } else { %>
                <a href="<%= +sFileName %>?<%=formParams+sSortParams %>&FormRecommended_Page=<%= (iPage + 1) %>#Form">
                    <font style="font-size: 10pt; color: #CE7E00; font-weight: bold">Next</font>
                </a><br>
        <%  } %>
            </td></tr>
    <% }
    }
     rs.close();
     out.println("    </table>");
  } catch (Exception e) { 
      out.println(e.toString());
    } %>
        </td><td valign="top">
            <% What_Show(request, response, session, out, sWhatErr, sForm, sAction, conn, stat); %>

            <% New_Show(request, response, session, out, sNewErr, sForm, sAction, conn, stat); %>

            <% Weekly_Show(request, response, session, out, sWeeklyErr, sForm, sAction, conn, stat); %>
       </td>
      </tr>
    </table>
    <%-- FOOTER Here --%>
    <jsp:include page="Footer.jsp" flush="true"/>

</body>
</html>
<%%>
<%
if ( stat != null ) stat.close();
if ( conn != null ) conn.close();
%>



  void What_Show (javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sWhatErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException  {
  
    String sWhere = "";
    int iCounter=0;
    int iPage = 0;
    boolean bIsScroll = true;
    boolean hasParam = false;
    String sOrder = "";
    String sSQL="";
    String transitParams = "";
    String sQueryString = "";
    String sPage = "";
    int RecordsPerPage = 20;
    String sSortParams = "";
    String formParams = "";


 
    // Build WHERE statement
        
    sWhere = " AND editorial_cat_id=1";

  // Build full SQL statement
  
  sSQL = "select e.article_desc as e_article_desc, " +
    "e.article_title as e_article_title, " +
    "e.item_id as e_item_id, " +
    "i.item_id as i_item_id, " +
    "i.image_url as i_image_url " +
    " from editorials e, items i" +
    " where i.item_id=e.item_id  ";
  
  sSQL = sSQL + sWhere + sOrder;

  String sNoRecords = "     <tr>\n      <td colspan=\"1\" style=\"background-color: #FFFFFF; border-width: 1\"><font style=\"font-size: 10pt; color: #000000\">No records</font></td>\n     </tr>";


  String tableHeader = "";
    
  
  try {
    out.println("    <table style=\"\">");
    out.println("     <tr>\n      <td style=\"background-color: #336699; text-align: Center; border-style: outset; border-width: 1\" colspan=\"1\"><a name=\"What\"><font style=\"font-size: 12pt; color: #FFFFFF; font-weight: bold\">What We're Reading</font></a></td>\n     </tr>");
    out.println(tableHeader);

  }
  catch (Exception e) {}

  
  try {
    java.sql.ResultSet rs = null;
    // Open recordset
    rs = openrs( stat, sSQL);
    iCounter = 0;
    
    java.util.Hashtable rsHash = new java.util.Hashtable();
    String[] aFields = getFieldsName( rs );

    // Show main table based on recordset
    while ( rs.next() ) {

      getRecordToHash( rs, rsHash, aFields );
      String fldarticle_desc = (String) rsHash.get("e_article_desc");
      String fldarticle_title = (String) rsHash.get("e_article_title");
      String flditem_id = (String) rsHash.get("i_image_url");
flditem_id="<img border=0 src=" + flditem_id + ">";

      out.print("     <tr>\n      <td style=\"background-color: #FFFFFF; border-style: inset; border-width: 0\"><font style=\"font-size: 10pt; color: #CE7E00; font-weight: bold\"></font> </td></tr><tr><td style=\"background-color: #FFFFFF; border-width: 1\">"); out.print("<a href=\"BookDetail.jsp?"+transitParams+"item_id="+toURL((String) rsHash.get("e_item_id"))+"&\"><font style=\"font-size: 10pt; color: #000000\">"+toHTML(fldarticle_title)+"</font></a>");

      out.println("</td>\n     </tr>");
      out.print("     <tr>\n      <td style=\"background-color: #FFFFFF; border-style: inset; border-width: 0\"><font style=\"font-size: 10pt; color: #CE7E00; font-weight: bold\"></font> </td></tr><tr><td style=\"background-color: #FFFFFF; border-width: 1\">"); out.print("<font style=\"font-size: 10pt; color: #000000\">"+fldarticle_desc+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      out.print("     <tr>\n      <td style=\"background-color: #FFFFFF; border-style: inset; border-width: 0\"><font style=\"font-size: 10pt; color: #CE7E00; font-weight: bold\"></font> </td></tr><tr><td style=\"background-color: #FFFFFF; border-width: 1\">"); out.print("<a href=\"BookDetail.jsp?"+transitParams+"item_id="+toURL((String) rsHash.get("e_item_id"))+"&\"><font style=\"font-size: 10pt; color: #000000\">"+flditem_id+"</font></a>");

      out.println("</td>\n     </tr>");
      out.println("     <tr>\n      <td colspan=\"2\" style=\"background-color: #FFFFFF; border-width: 1\">&nbsp;</td>\n     </tr>");
    
      iCounter++;
    }
    if (iCounter == 0) {
      // Recordset is empty
      out.println(sNoRecords);
    
      iCounter = RecordsPerPage+1;
      bIsScroll = false;
    }

    if ( rs != null ) rs.close();
    out.println("    </table>");
    
  }
  catch (Exception e) { out.println(e.toString()); }
}


  void Categories_Show (javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sCategoriesErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException  {
 
}


  void New_Show (javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sNewErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException  {
  
    String sWhere = "";
    int iCounter=0;
    int iPage = 0;
    boolean bIsScroll = true;
    boolean hasParam = false;
    String sOrder = "";
    String sSQL="";
    String transitParams = "";
    String sQueryString = "";
    String sPage = "";
    int RecordsPerPage = 20;
    String sSortParams = "";
    String formParams = "";


 
    // Build WHERE statement
        
    sWhere = " AND editorial_cat_id=2";

  // Build full SQL statement
  
  sSQL = "select e.article_desc as e_article_desc, " +
    "e.article_title as e_article_title, " +
    "e.item_id as e_item_id, " +
    "i.item_id as i_item_id, " +
    "i.image_url as i_image_url " +
    " from editorials e, items i" +
    " where i.item_id=e.item_id  ";
  
  sSQL = sSQL + sWhere + sOrder;

  String sNoRecords = "     <tr>\n      <td colspan=\"3\" style=\"background-color: #FFFFFF; border-width: 1\"><font style=\"font-size: 10pt; color: #000000\">No records</font></td>\n     </tr>";


  String tableHeader = "";
    tableHeader = "     <tr>\n      <td colspan=\"1\" style=\"background-color: #FFFFFF; border-style: inset; border-width: 0\"><font style=\"font-size: 10pt; color: #CE7E00; font-weight: bold\"></font></td>\n      <td colspan=\"1\" style=\"background-color: #FFFFFF; border-style: inset; border-width: 0\"><font style=\"font-size: 10pt; color: #CE7E00; font-weight: bold\"></font></td>\n      <td colspan=\"1\" style=\"background-color: #FFFFFF; border-style: inset; border-width: 0\"><font style=\"font-size: 10pt; color: #CE7E00; font-weight: bold\"></font></td>\n     </tr>";
  
  
  try {
    out.println("    <table style=\"\">");
    out.println("     <tr>\n      <td style=\"background-color: #336699; text-align: Center; border-style: outset; border-width: 1\" colspan=\"3\"><a name=\"New\"><font style=\"font-size: 12pt; color: #FFFFFF; font-weight: bold\">New & Notable</font></a></td>\n     </tr>");
    out.println(tableHeader);

  }
  catch (Exception e) {}

  
  try {
    java.sql.ResultSet rs = null;
    // Open recordset
    rs = openrs( stat, sSQL);
    iCounter = 0;
    
    java.util.Hashtable rsHash = new java.util.Hashtable();
    String[] aFields = getFieldsName( rs );

    // Show main table based on recordset
    while ( rs.next() ) {

      getRecordToHash( rs, rsHash, aFields );
      String fldarticle_desc = (String) rsHash.get("e_article_desc");
      String fldarticle_title = (String) rsHash.get("e_article_title");
      String flditem_id = (String) rsHash.get("i_image_url");
flditem_id="<img border=0 src=" + flditem_id + ">";

      out.println("     <tr>");
      
      out.print("      <td style=\"background-color: #FFFFFF; border-width: 1\">"); out.print("<a href=\"BookDetail.jsp?"+transitParams+"item_id="+toURL((String) rsHash.get("e_item_id"))+"&\"><font style=\"font-size: 10pt; color: #000000\">"+toHTML(fldarticle_title)+"</font></a>");

      out.println("</td>");
      out.print("      <td style=\"background-color: #FFFFFF; border-width: 1\">"); out.print("<a href=\"BookDetail.jsp?"+transitParams+"item_id="+toURL((String) rsHash.get("e_item_id"))+"&\"><font style=\"font-size: 10pt; color: #000000\">"+flditem_id+"</font></a>");

      out.println("</td>");
      out.print("      <td style=\"background-color: #FFFFFF; border-width: 1\">"); out.print("<font style=\"font-size: 10pt; color: #000000\">"+toHTML(fldarticle_desc)+"&nbsp;</font>");
      out.println("</td>");
      out.println("     </tr>");
    
      iCounter++;
    }
    if (iCounter == 0) {
      // Recordset is empty
      out.println(sNoRecords);
    
      iCounter = RecordsPerPage+1;
      bIsScroll = false;
    }

    if ( rs != null ) rs.close();
    out.println("    </table>");
    
  }
  catch (Exception e) { out.println(e.toString()); }
}


  void Weekly_Show (javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response, javax.servlet.http.HttpSession session, javax.servlet.jsp.JspWriter out, String sWeeklyErr, String sForm, String sAction, java.sql.Connection conn, java.sql.Statement stat) throws java.io.IOException  {
  
    String sWhere = "";
    int iCounter=0;
    int iPage = 0;
    boolean bIsScroll = true;
    boolean hasParam = false;
    String sOrder = "";
    String sSQL="";
    String transitParams = "";
    String sQueryString = "";
    String sPage = "";
    int RecordsPerPage = 20;
    String sSortParams = "";
    String formParams = "";


 
    // Build WHERE statement
        
    sWhere = " AND editorial_cat_id=3";

  // Build full SQL statement
  
  sSQL = "select e.article_desc as e_article_desc, " +
    "e.article_title as e_article_title, " +
    "e.item_id as e_item_id, " +
    "i.item_id as i_item_id, " +
    "i.image_url as i_image_url " +
    " from editorials e, items i" +
    " where i.item_id=e.item_id  ";
  
  sSQL = sSQL + sWhere + sOrder;

  String sNoRecords = "     <tr>\n      <td colspan=\"1\" style=\"background-color: #FFFFFF; border-width: 1\"><font style=\"font-size: 10pt; color: #000000\">No records</font></td>\n     </tr>";


  String tableHeader = "";
    
  
  try {
    out.println("    <table style=\"\">");
    out.println("     <tr>\n      <td style=\"background-color: #336699; text-align: Center; border-style: outset; border-width: 1\" colspan=\"1\"><a name=\"Weekly\"><font style=\"font-size: 12pt; color: #FFFFFF; font-weight: bold\">This Week's Featured Books</font></a></td>\n     </tr>");
    out.println(tableHeader);

  }
  catch (Exception e) {}

  
  try {
    java.sql.ResultSet rs = null;
    // Open recordset
    rs = openrs( stat, sSQL);
    iCounter = 0;
    
    java.util.Hashtable rsHash = new java.util.Hashtable();
    String[] aFields = getFieldsName( rs );

    // Show main table based on recordset
    while ( rs.next() ) {

      getRecordToHash( rs, rsHash, aFields );
      String fldarticle_desc = (String) rsHash.get("e_article_desc");
      String fldarticle_title = (String) rsHash.get("e_article_title");
      String flditem_id = (String) rsHash.get("i_image_url");
flditem_id="<img border=0 src=" + flditem_id + ">";

      out.print("     <tr>\n      <td style=\"background-color: #FFFFFF; border-style: inset; border-width: 0\"><font style=\"font-size: 10pt; color: #CE7E00; font-weight: bold\"></font> </td></tr><tr><td style=\"background-color: #FFFFFF; border-width: 1\">"); out.print("<a href=\"BookDetail.jsp?"+transitParams+"item_id="+toURL((String) rsHash.get("e_item_id"))+"&\"><font style=\"font-size: 10pt; color: #000000\">"+toHTML(fldarticle_title)+"</font></a>");

      out.println("</td>\n     </tr>");
      out.print("     <tr>\n      <td style=\"background-color: #FFFFFF; border-style: inset; border-width: 0\"><font style=\"font-size: 10pt; color: #CE7E00; font-weight: bold\"></font> </td></tr><tr><td style=\"background-color: #FFFFFF; border-width: 1\">"); out.print("<a href=\"BookDetail.jsp?"+transitParams+"item_id="+toURL((String) rsHash.get("e_item_id"))+"&\"><font style=\"font-size: 10pt; color: #000000\">"+flditem_id+"</font></a>");

      out.println("</td>\n     </tr>");
      out.print("     <tr>\n      <td style=\"background-color: #FFFFFF; border-style: inset; border-width: 0\"><font style=\"font-size: 10pt; color: #CE7E00; font-weight: bold\"></font> </td></tr><tr><td style=\"background-color: #FFFFFF; border-width: 1\">"); out.print("<font style=\"font-size: 10pt; color: #000000\">"+toHTML(fldarticle_desc)+"&nbsp;</font>");
      out.println("</td>\n     </tr>");
      out.println("     <tr>\n      <td colspan=\"2\" style=\"background-color: #FFFFFF; border-width: 1\">&nbsp;</td>\n     </tr>");
    
      iCounter++;
    }
    if (iCounter == 0) {
      // Recordset is empty
      out.println(sNoRecords);
    
      iCounter = RecordsPerPage+1;
      bIsScroll = false;
    }

    if ( rs != null ) rs.close();
    out.println("    </table>");
    
  }
  catch (Exception e) { out.println(e.toString()); }
}

%>