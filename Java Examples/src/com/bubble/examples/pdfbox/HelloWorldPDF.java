import org.apache.pdfbox.pdmodel.*;
import org.apache.pdfbox.pdmodel.font.*;
import org.apache.pdfbox.pdmodel.edit.*;
public class HelloWorldPDF {
public static void main(String[] args) throws Exception {
PDDocument document = new PDDocument();
PDPage page = new PDPage();
document.addPage(page);
PDFont font = PDType1Font.HELVETICA_BOLD;
PDPageContentStream contentStream = new PDPageContentStream(document, page);
contentStream.beginText();
contentStream.setFont( font, 12 );
contentStream.moveTextPositionByAmount( 100, 700 );
contentStream.drawString( "Hello World" );
contentStream.endText();
contentStream.close();

document.save("TestPDF.pdf");
document.close();
}
}

