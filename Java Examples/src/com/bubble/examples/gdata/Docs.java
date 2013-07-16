import com.google.gdata.client.*;
import com.google.gdata.client.docs.*;
import com.google.gdata.data.docs.*;
import com.google.gdata.data.acl.*;
import com.google.gdata.util.*;
import com.google.gdata.data.PlainTextConstruct;
import java.net.URL;
import java.io.*;
public class Docs {
    
    DocsService client = null;
    public  Docs(String user, String password) throws AuthenticationException {
        client = new DocsService("Company");
        client.setUserCredentials(user, password);
        System.out.println("Done");
    }

    public static void main(String[] args) throws AuthenticationException, IOException, ServiceException {
        Docs docs = new Docs("sundeep.techie@gmail.com", "gr33N!e.");
        // docs.showAllDocs();
        DocumentListEntry uploadedEntry = docs.uploadFile("/home/soulful/facebook/test.html", "Upload Python");
        System.out.println("Document now online @ :" + uploadedEntry.getHtmlLink().getHref());
    }

    public void showAllDocs() throws IOException, ServiceException {
        String href = "https://docs.google.com/feeds/default/private/full";
        URL feedUri = null;
        DocumentListFeed feed = null;
        int i = 0;
        do {
            // URL feedUri = new URL("https://docs.google.com/feeds/documents/private/full");
            feedUri = new URL(href);
            feed = client.getFeed(feedUri, DocumentListFeed.class);
            for (DocumentListEntry entry : feed.getEntries()) {
                i++;
                // printDocumentEntry(entry);
            }
            System.out.println();
            if (feed.getNextLink() == null ) {
                break;
            }
            href = feed.getNextLink().getHref();
   
           /* feed = client.getFeed(new URL(feed.getNextLink().getHref()), DocumentListFeed.class);
        for (DocumentListEntry entry : feed.getEntries()) {
            printDocumentEntry(entry);
        }
          */
        } while (true);
        System.out.println(i);
    }
    public void printDocumentEntry(DocumentListEntry doc) {
        String resourceId = doc.getResourceId();
        String docType = resourceId.substring(0, resourceId.lastIndexOf(':'));
        System.out.print("'" + doc.getTitle().getPlainText() + "' (" + docType + ")\t");
    }


        
public DocumentListEntry uploadFile(String filepath, String title)
    throws IOException, ServiceException  {
  File file = new File(filepath);
  DocumentListEntry newDocument = new DocumentListEntry();
  String mimeType = DocumentListEntry.MediaType.fromFileName(file.getName()).getMimeType();
  newDocument.setFile(new File(filepath), mimeType);
  newDocument.setTitle(new PlainTextConstruct(title));

  return client.insert(new URL("https://docs.google.com/feeds/default/private/full/"), newDocument);
}
}
