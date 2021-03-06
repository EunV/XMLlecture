import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.helpers.XMLReaderFactory;

public class SaxHandlerClass extends DefaultHandler {
    public static void main(String[] args) throws Exception {
        System.out.println("Start");
        SaxHandlerClass saxHandlerClass = new SaxHandlerClass();
        saxHandlerClass.read(args[0]);
    }

    public void read(String fileName) throws Exception {
        XMLReader readerObj = XMLReaderFactory.createXMLReader(
                "org.apache.xerces.parsers.SAXParser"
        );
        readerObj.setContentHandler(this);
        readerObj.parse(fileName);
    }

    @Override
    public void startDocument() throws SAXException {
        System.out.println("parsing Start");
    }

    @Override
    public void endDocument() throws SAXException {
        System.out.println("parsing End");
    }

    @Override
    public void startElement(String uri, String localName, String fullName, Attributes atts) throws SAXException {
        System.out.println("Element is : " + fullName);
    }
}