import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.helpers.XMLReaderFactory;

public class SaxHandlerClass2 extends DefaultHandler {
    private StringBuffer strbuff = new StringBuffer();
    private String whatElement;

    public static void main(String[] args) throws Exception {
        System.out.println("Start");
        SaxHandlerClass2 saxHandlerClass = new SaxHandlerClass2();
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
    public void startElement(String uri, String localName, String fullName, Attributes atts) throws SAXException {
        System.out.println("Element is : " + fullName);
        whatElement = fullName;
        strbuff.setLength(0);
    }

    @Override
    public void endElement(String uri, String localName, String qName) throws SAXException {
        if (whatElement.equals("이름") && strbuff.length() > 0) {
            System.out.println(localName + " has " + strbuff);
            strbuff.setLength(0);
        }
    }

    @Override
    public void characters(char[] chars, int start, int len) throws SAXException {
        this.strbuff.append(chars, start, len);
    }


    @Override
    public void endDocument() throws SAXException {
        System.out.println("parsing End");
    }
}
