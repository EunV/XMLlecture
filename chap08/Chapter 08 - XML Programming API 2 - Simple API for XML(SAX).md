# Chapter 08 - XML Programming API 2 - Simple API for XML(SAX)

## 1. SAX의 개념
- The Simple API for XML
- DOM이 작은 용량을 다룰 때 편리하지만, SAX는 수 MB 이상의 XML을 다룰 때 유용
- 큰 XML 문서를 event-driven 방식으로 분석할 수 있도록 개발된 API
---
## 2. SAX 동작구조
### 2.2.1. DOM과 SAX의 비교 
<img src="img/SAX%20Structure.png">
  
* DOM
  * 크기가 작은 파일에 적합
  * 데이터를 **편하게 접근하고자 할 때 유용**
  * DOM Tree를 메모리에 전부 올리기 때문에 큰 파일에는 부적합

* SAX 
  * 크기가 큰 파일에 적합
  * XML 문서에서 원하는 부분이 전체가 아닌 파일의 극히 일부일 때
  * 스트림 방식에서 훑고 지나가기 때문에 **속도**는 DOM에 비해 빠름
    * 단, DOM처럼 지나간 부분을 다시 접근하는 것은 불가능

### 2.2.2. 동작순서(JAVA 기준)
1. Client Code에 ContentHandler interface를 지원하는 객체 생성 __saxhandler__
2. saxhanlder를 XML 파서에 등록
3. xml파서는 **특정 Event** 발생 할 때마다, 해당 event를 처리하는 method(**event-handler**)를 saxhandler에서 호출

* SAX 관련 프로그래밍이란?
    ContentHandler Interface 를 지원하는 클래스에서 처리를 원하는 event에 대한 event handler를 새로 작성하여 override 하는것. 
    --> event handle달기
* 앞의 내용을 보고 뒷 내용을 본 후에는 다시 앞의 내용을 볼 수는 없음의 유의


## 3. SAX 실행환경
* Java Interface 사용
  * Apache Xerces 1.4.4
  * 라이브러리 import 및 환경 변수 설정 필요

## 4. SAX 맛보기(EX 8-1)
~~~xml
<!-- 사용할 XML-->
<?xml version="1.0" encoding="UTF-8"?>
<주소록>
    <회원>
        <이름>박성숙</이름>
        <영문이름>Park, Seong Sook</영문이름>
        <주소>서울시 어느구 어느동</주소>
        <전화번호>487-5555</전화번호>
    </회원>

    <회원>
        <이름>조정헌</이름>
        <영문이름>Cho,Jeong Heon</영문이름>
        <주소>서울시 어떤구 어떤동</주소>
        <전화번호>445-6789</전화번호>
    </회원>
</주소록>
~~~
~~~java
//SAX 
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
~~~
아래는 실행결과
~~~text
start...
parsing start ...
Element is 주소록
Element is 회원
Element is 이름
Element is 영문이름
Element is 주소
Element is 전화번호
Element is 회원
Element is 이름
Element is 영문이름
Element is 주소
Element is 전화번호
parsing end.
~~~

## 5. SAX 작성
### 5.1. Content Handler 지원 클래스 작성
  * 직접 ContentHandler interface의 모든 함수 구현
   ~~~java
      public class MyClass implements ContentHandler
   ~~~
  * ContentHandler interface를 미리 구현한 DefaultHandler를 이용하여 필요한 것만 사용
   ~~~java
    public class MyClass extends DefaultHandler
   ~~~
      * interface 구현이 필요 없기 때문에 주로 사용되는 방법
      * 메소드 오버라이딩
  
### 5.2. ContentHandler의 주요 methods
* startDocument()
* endDocument()
* startElement(String uri, String localName, String fullName, Attributes atts)
    * 시작 태그를 만날 때
* endElement(String uri, String localName, String fullName, Attributes atts)
    * 끝 태그를 만날 때
* characters(char[] chars, int start, int len)
    * Element가 text 노드 값을 가고 있을 때, 읽기 위한 함수

### 5.3. element tag내의 문자열 정보 읽기(EX8-2)
* characters(char[] chars, int start, int len)
* 한 element tag내의 문자열을 읽을 때, parser 구현의 필요성으로 인하여 여러 번 호출 될 수 있음. 
  * 내부에 버퍼를 충분한 크기로 가지고 있으나, 길이에 대한 제약은 없으므로 확신할 수는 없다.
  * 예: `<address> 서울시 관악구 신림동 … </address>`
  * 한번에 ‘서울시…’ 을 모두 characters 로 넘겨준다는 보장은 없음.
  * ‘서울시 관악’, ‘구 신림동 .. ‘ 이런 식으로 나뉠 수 있음
  * 만일의 경우에 대처 해야하는 만큼 아래의 방법을 사용
* 일반적으로 문자열 임시 저장소를 만든 다음, 이곳에 append
    * private StringBuffer strbuff = new StringBuffer();
    * in characters(), "strbuff.append(chars, start, len);"

* 실습예제
~~~ java
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
~~~


### 5.4. Attributes 정보 얻기(EX8-3)
* startElement(String uri, String localName, String fullName,Attributes atts)
* 4 methods of Attributes object
    * int getLength() : 속성의 개수 반환
    * String getQName(int index) : index번째의 속성 이름을 반환
    * String getLocalName(int index): index 번째의 속성이름을 반환
    * String getValue(int index): index 번째의 속성 값을 반환
    * String getValue(String name): name에 해당하는 속성 값을 반환
    * String getType(int index): index번째 속성의 형식을 반환
    * String getType(String name): name에 해당하는 속성 값을 반환

* 실습예제
~~~ java
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.helpers.XMLReaderFactory;


public class SaxHandlerClass3 extends DefaultHandler {
    public static void main(String[] args) throws Exception {
        System.out.println("Start");
        SaxHandlerClass3 saxHandlerClass = new SaxHandlerClass3();
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
        System.out.println("Element is : " + fullName + "");
        int amount = atts.getLength();
        for (int i = 0; i < amount; i++) {
            String name = atts.getLocalName(i);
            String value = atts.getValue(i);
            System.out.printf("Element(%s) has attr(%s), value(%s)\n", localName, name, value);
        }
    }
}
~~~