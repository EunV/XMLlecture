# Chapter 07 - Document Object Model(DOM)

## 1. DOM이란?

**플랫폼, 언어 중립적인 인터페이스** 
- 문서의 내용 및 구조/ 스타일을 동적으로 접근하고 수정할 수 있게 하는 **인터페이스** 

### 1.1. Interface란?
**the set of method signatues**
- Method signature: **method name + arguments (+ return type)**
- 메소드명, 매개변수, 필요할 경우 반환 타입 정도의 선언만 되어있음
- 클래스 상속 vs 인터페이스 구현


## 2. DOM 실습 환경
- DOM은 interface spec. 으로, 이를 programming에서 활용하기
위해서는 DOM spec.을 구현한 library가 필요
- 현재 Script languages, JAVA, C++, C#등을 지원하는 많은
Library가 발표되어 있음
- 여기서는 MSXML 3.0(또는 4.0)을 이용. **Java Script** 언어를 사용하고, IE에서 코드 동작을 확인

## 3. DOM Tree 구조
### 3.1. Dom Tree의 생성
    (1) XML이 파서에 의해 읽혀진다
    (2) 파서가 메인 메모리에 DOM Tree를 만든다. Dom Tree 구조의 예시는 아래와 같음
---
* Root Element 
    * Child Element
      * Text Node
    * Child Element 
      * Child Element
        * Text Node
      * Text Node
--- 
    (3) DOM Tree로 변환 (== DOM Tree 생성)
    (4) DOM Tree를 통해 App이나 Script에서 읽고 쓴다
* 다만, 대부분의 브라우저들이 보안을 위해 javascript를 통해서는 save 기능을 막아놓은 만큼, 실습에서는 Dom Tree를 불러오는 정도만 다룬다. 

### 3.2. DOM TREE의 요소들
* Document ('/')
  * Document Element
    * Element
      * Attribute
        * Text
      * Text
    * Element
---

* Document : DOM Tree의 최상위 노드. **XML 문서를 대표**
    * 이 노드는 PI 문장 및 root element를 포함
* Element 또는 Attribute가 문자열을 가진다면, **Text 노드**를 가지게 되고 이 노드를 통해 접근한다.

* Document 객체는 다른 개체를 생성할 수 있다.
* **Document Element : root Element (매우 중요!)**
  * root document가 가지는 property 중 하나임

* 각 노드는 Node이자 Element이며 여러가지 역할을 할 수 있다.

### 3.3. DOM TREE의 예시

### EX 7-1 : Dom Tree 구조 작성
~~~xml
<?xml version="1.0" encoding="euc-kr"?>
    <order number=“3123”>
        <date> 2002/1/1</date>
            <customer id=“216A”> Company A </customer>
    <item>
        <part-number warehouse=“Warehouse 11”> E16-25A </part-number>
        <quantity> 16 </quantity>
    </item>
</order>
~~~
    0. document (<-- document Root)
    1. Element("order") (<--'Root Element' or 'documentElement')
        2. Attribute("number")
            3. Text("3123")

        2. Element("date")
            3. Text("2002/1/1")

        2. Element("customer")
            3. Attribute("id")
                4. Text("216A")
            3. Text("Company A")
    
        2. Element("item")
            3. Element("part-number")
                4. Attribute("warehouse")
                    5.Text("Warehouse 11")
                4. Text("E16-25A")
            3. Element("quantity")
                4. Text("16")

---

### 4. DOM의 핵심 인터페이스
### 4.1. 핵심 Object 및 인터페이스
* **DOMDocument**
  * XML 문서 전체를 대표하는 DOM tree 최상위 노드 객체
  * **인터페이스가 아님에 유의**
  * 따라서, 구현이 아닌 **생성**이며, 클래스의 일종.
  * 이것을 통해 다른 노드 등을 만들고 수정할 수 있다

* IXMLDOMNode
    * tree 내의 독립적인 node를 나타냄. 가장 기본적인 Interface
    * 가장 많은 메소드와 속성을 지닌다
    * 모든 Node에 적용
    * 
가장 property(마치 member value처럼 '보인다')가 많고, method가 많다.
setter, getter로 접근 가능하면 property라고 한다. (일종의 가상의 멤버변수)
대신, 멤버 변수가 있는지 없는지는 중요하지 않다.
* IXMLDOMNodeList
    * Node들의 collection.
    * DOM Tree를 묶어놓은 배열
    * JAVA의 인터페이스와는 다르게 '변수 비스무리한' property를 가진다
      * 가상의 멤버 변수이면서 일종의 함수로도 볼 수 있따
      * 그러나 getter 함수, setter 함수. 멤버 변수의 유무는 중요하지 않음
* IXMLDOMElement
  * element node 대표
* IXMLDOMAttribute
  * attribute node 대표
* IXMLDOMText, IXMLDOMCharacterData, IXMLDOMComment
    * 기본적으로 Text Data를 가지는 node 대표

## 4.2. DOM interface 상속 관계

## 4.3. IXMLDOMNode
### 4.3.1. Properties : 정보를 읽는 것에 집중
* 정보
  * '+' : 읽고 쓰기 가능 (이것이 없는 경우 기본적으로 **Read Only**)
  * '*' : MS의 확장
  
    * attributes: 현재 node의 attribute 목록을 NamedNodeMap 형식으로 반환
    * childNodes: 모든 자식 node들을 NodeList 형식으로 반환
      * **attribute는 제외됨에 유의** 
      * 보통 자식 노드로는 Element와 Text를 가진다.
    * firstChild: 첫번째 자식 node
    * lastChild: 마지막 자식 node
    * nextSibling: 현재 node의 다음 번에 위치한 형제 node반환
    * prviousSibling : 이전 형제 node 반환
    * nodeName: 현재 node의 이름 (예: 요소의 경우 tag이름)
    * nodeType: 현재 node의 type 을 번호로 반환 (NODE_XXXX)
      * 1~5: ELEMENT, ATTRIBUTE, TEXT, CDATA_SECTION, ENTITY_REFERENCE
      * 6~10: ENTITY, PROCESSING_INSTRUCTION, COMMENT, DOCUMENT
      * 10~12: DOCUMENT_TYPE, DOCUMENT_FRAGMENT, NOTATION
    * nodeTypeString*: node type을 문자열로 반환
      * MS의 확장으로 비표준
    * nodeValue+: 현재 node의 값 (text node일 때 의미가 있음)
    * ownerDocument: 현재 node를 포함하는 document 객체를 반환
      * **Xpath의 '/'** --> DOM Tree의 루트.최고 조상. **root element는 아님에 유의** 
    * parentNode: 현재 node의 부모 node를 반환
    * previousSibling: 현재 node의 이전 번에 위치한 형제 node반환
    * text*+: 현재 node와 그 하위 node들이 가지고 있는 모든 텍스트내용 반환
      * MS의 확장으로 비표준이지만, 현재 노드를Text 표현으로 반환
    * xml*: 현재 node와 그 하위 Node들의 XML 표현을 반환
      * MS의 확장으로 비표준 
---

### 4.3.1.1. 요약
    IXMLDOMNode
    .ownerDocument : DOMDocument

    자기 자신을 표현하는 property
    .nodeType
    .nodeName
    .nodeValue

    관계
    .attributes 복수형
    .chlidNodes 복수형
    .firstChild
    .lastChild

    .previousSibling
    .nextSibling

    .text
    .xml
----

### 4.3.2. Methods : 구조나 내용을 변경하는 것에 집중
  * appendChild: 현재 node의 자식 node 목록에 새 node를 끝에 추가
  * cloneNode: 현재 node를 복사하여 반환
  * hasChildNodes: 현재 node에 자식 node들이 있는지 여부 반환
  * insertBefore: 새 node를 지정된 하위 node 앞에 자식node로 삽입. 
  * removeChild: 특정 자식 node를 자식 Node 목록에서 삭제하고 이 삭제된 node를 반환
  * replaceChild: 특정 자식 node를 새로운 node로 대체하고 교체된 node를 반환
  * **selectSingleNode*, selectNodes*: 현재 Node와 그 자식 node들에 있어서 지정된 Xpath를 만족시키는 노드(들)을 반환**
    * 정보를 읽는 것
    * **반환타입 : IXMLDOMNodeList**
    * **자주 사용할 함수지만 비표준**
---

### 4.4 IXMLDOMNodeList
### 4.4.1. properties
* item : index를 인자로 받아서 해당 위치의 node 반환 (0부터 시작. zero-based)
  * JS에서는 nodes[0] , nodes[1] , nodes[2] 형태와 같이 배열처럼 사용가능
* length : node개수 반환

### 4.4.2. methods
* reset : iterator 위치 reset
* nextNode : iterator에서 다음 위치의 node 반환
---

### 4.5. DOMDocument (IXMLDOMNode interface 상속)
* 대부분의 기능은 IXMLDOMNode단에서 처리가 가능
### 4.5.1. Properties
* doctype: 현재 문서에 대한 DTD를 정의하는 doctype node 반환
* **documentElement+ : DOM Tree의 root element 반환**
  * DOMDocument 객체가 파서 역할을 해준다(?)
  * 쓰기 가능
* Implementation: 현재 문서에 대한 IXMLDOMimplementation 반환
* async*+: 지정된 URL로 부터 비동기적으로 다운로드할 지 여부 결정
  * 동기적으로 읽는 것 : XML파일을 **전부** 읽고 DOMTree 완성후 반환.
    * 동기적으로 읽을 경우 용량에 따라 시간이 오래 걸릴 수도 있음
* **readyState* : XML 문서의 현재상태를 반환**
  * DOM Tree 완성 여부 확인 가능

### 4.5.2. Methods
* create???: 해당 문서에 특정 node를 생성하는 Factory함수들
  * ???: Element, Attribute, CDATASection, Comment, EntityReference,ProcessingInstruction, TextNode
* **getElementsByTagName: 지정된 이름의 element 집합들을 반환**
  * **반환형 : IXMLDOMNodeList**
* load*: 외부의 XML 문서파일을 지정하여 메모리에 읽음
  * **XML 파일에서 읽어옴**
* loadXML*: 지정된 문자열을 XML 문서내용으로 하여 DOM Tree 생성
  * **문자열에서 읽어옴**
* save*: DOM Tree를 외부 파일로 저장
  * 보안 정책상 동작하지는 않는다.
---
### 4.6IXMLDOMElement (IXMLDOMNode interface 상속)
### 4.6.1 properties
* tagName : 현재 element의 태그이름을 반환
  * IXMLDOMNode의 **nodeName**에 해당
### 4.6.2 methods
* **getAttribute**: 주어진 이름의 attribute 값 반환
* **setAttribute**: attribute 의 값을 지정
* **getAttributeNode**: 주어진 이름의 attribute node 반환
* **setAttributeNode**: 현재 요소에 새로운 attribute를 추가하거나 변경
* **getElementsByTagName: 지정된 이름의 element 집합들을 반환**
  * 정말 자주 사용하는 함수
* **selectNodes("//...") : xPath를 통해 사용**
* normalize: 인접한 여러 개의 text 노드들을 하나로 합침
* **removeAttribute**: 주어진 이름의 attribute를 제거하거나 대체
* **removeAttributeNode**: 주어진 attribute node를 제거
---

### 4.7. IXMLDOMAttribute(IXMLDOMNode interface 상속)
### 4.7.1. properties
* **name**: attribute 이름을 반환
* **value+**: attribute 값을 반환
---
    Elemnt와 attribute에서 값을 접근하는 방식의 차이
    Element : firstChild(text) node를 경유
    Attribute : Element와 같은 방식으로 접근해도 되고 바로 nodevalue로 접근할 수도 있다.
---
### 4.8. IXMLDOMCharacterData
### 4.8.1. properties - Text
* data+: 현재 node의 type에 따른 데이터(문자열)를 반환 **= nodeValue**
* length: 데이터의 character 개수를 반환

### 4.8.2 methods
* appendData: nText.appendData(“.”) à “welcome” 에서 “welcome.” 로
* deleteData: nText.deleteData(2,4) à “welcome” 에서 “wee” 로
* insertData: nText.insertData(2,”!!”) à “welcome” 에서 “we!!lcome” 로
* replaceData: nText.replaceData(2,4,”.”) à “welcome” 에서 “we.e” 로
* substringData: nText.substringData(2,4) à “welcome” 중 “lcom” 반환
  * 매개변수 : (start,length)

## EX 7-2
생략.

## 5. XML 문서 내용 읽기
### 5.1. 문서 내용 읽는 순서

1. DOMDocument객체 xmldoc 생성
2. xmldoc에 XML 문서 내용 지정 (파일 or 문자열)
 * 파싱 과정을 거쳐 DOM Tree가 생성됨.
3. xmldoc의 여러 properties나 methods를 이용해서 하위 요소들을 검색한다.
* documentElement
* childNodes
* attributes
* firstChild, lastChild
* getElementsByTagName()
  * 아래의 함수들과 비교를 해볼 때 표준함수이며, 성능 상에서 약간 우월
* selectSingleNode(), selectNodes()

### 5.2. JS코드로 보는 예시
~~~ Javascript
var xmldoc;
var xmlErr;
function FileLoad() {
    xmldoc = new ActiveXObject("MSXML.DOMDocument");
    xmldoc.async = false;
    // DOM Tree 완성 이후에 다루는 것이 쉬우므로 async=false
    xmldoc.load(path.value);
    xmlErr = xmldoc.parseError;
    if (xmlErr.errorCode != 0)
        alert("Error!, " + xmlErr.reason);
    else
        alert("Success!");
}
function Execute() {
    var selectionString;
    try {
        selectionString = eval(syntax.value);
    }
    catch (e) {
        selectionString = null;
    }
    alert(selectionString);
}
~~~
---
## EX 7-3
생략
---
## 6. 하위 Element 접근
### 6.1. 접근 순서
1. DOMDocument객체 xmldoc 생성
2. xmldoc의 childNodes 속성 이용
   * IXMLDOMNodeList
   * childNodes(i) 형태 사용
   * childNodes.item(i) , childNodes.length 사용
---
## EX 7-4
생략
---
## 7. 특정 Element 접근
### 7.1. 접근 순서
1. DOMDocument객체 xmldoc 생성
2. DOMDocument.getElementsByTagName()사용
   * **태그 이름으로 찾기**
   * IXMLDOMNODEList xmldoc.getElementsByTagName(name)
   * IXMLDOMNODEList의 item,length 사용
     * nodeList.item(0) 또는 JS의 경우 nodeList[0]
     * nodeList.item(nodeList.length-1) 또는 JS의 경우 nodeList[nodeList.length-1]
     * nodeList.item(n).nodeValue 또는 JS의 경우 nodeList[n].nodeValue
       * n번째 요소가 Text를 값으로 가진다면 Text Node(firstChild)의 값을 읽는다.

3. DOMDocument.selectNodes()사용
   * **Xpath path로 찾기**
   * Xpath path를 지정하여 원하는 개체를 찾는다.
---
## EX7-5
생략
---

## 8. Attribute 접근
* Attribute는 text를 거치지 않아도 nodeValue로 바로 접근이 가능함을 기억할 것.
* 
### 8.1. 특정 Element Node의 attribute 접근
* IXMLDOMNode의 attributes 속성 이용
* IXMLDOMNamedNodeMap 활용하기
    * IXMLDOMNode getNamedItem(attribute이름)
      * **이 방법이 가장 편함**
    * IXMLDOMNodeList 와 같이 item(), length 속성 제공
        * 하나만 있을 경우 firstChild로 접근 해도 됨
        * cf. 단, NamedNodeMap은 XML 문서에 나오는 순서는 보장하지 않는다.
  
### 8.1.1 접근 순서
* **먼저 Element를 찾는다 -> 그 다음 attributes를 찾는다**
1. attribute 를 가지는 특정 Node에 접근 – node
2. attrList = node.attributes;
3. attrNode = attrList.getNamedItem(“id”);
4. attrNode.firstChild.nodeValue; or attrNode.nodeValue
5. node.attributes.setNamedItem(attrNode25

## EX 7-6 
생략

## 9. XML 문서 생성
* DOMDocument 외엔 모두 Interface
  * **Document 객체만 생성가능** 
  * 다른 Node들 생성은 Document의 Factory 기능을 이용한다. 
    * createNodeType()
  * IXMLDOMNode.appendChild()로 원하는 위치에 삽입도 가능
* XML 문서 생성
  1. DOMDocument xmldoc 생성
  2. xmldoc의 factory 함수를 이용하여 필요한 node 생성
  3. 생성된 node를 DOM tree의 원하는 위치에 삽입
  4. DOM tree를 외부 xml 파일로 저장
    * 다만 저장은 브라우저 보안 정책에 의해 동작은 안 한다.

### 9.1. Node관련 method
### 9.1.1. IXMLDOMDocument
* createNodeType()
    * Node, Element, Attribute, Comment, TextNode, …
* save(filename)
  * XML 파일로 저장(동작 X)
### 9.1.2 IXMLDOMNode
* appendChild( IXMLDOMNode )
* insertBefore( 새Node, 기존Node )
* IXMLDOMNode removeChild( 지울Node 
* IXMLDOMNode replaceChild( 새Node, 옛Node )

## 9.2. 순서
* JS코드
~~~Javascript
 var xmldoc = new ActiveXObject("MSxml2.DOMDocument");
 /*1. Dom Document 생성*/
 var simple = xmldoc.createElement("simple");
 var names = new Array("김기수", "홍길동", "신현아", "장나라");
 for (var i = 0; i < names.length; i++) {
     /*2. 필요한 노드들 생성*/
     var nameNode = xmldoc.createElement("name");
     var textNode = xmldoc.createTextNode(names[i]);

     /*3. 노드만 생성되었지, 관계는 만들어지지 않았으므로 appendChild로 관계 만듦*/
     nameNode.appendChild(textNode);
     simple.appendChild(nameNode);
 }
 /*4. 루트노드 지정 */
 xmldoc.documentElement = simple;
 alert(xmldoc.xml);
~~~

* 생성된 XML 
~~~xml
<?xml version="1.0" ?>
<simple>
    <name> <first> 기수 </first> <last> 김 </last> </name>
    <name> <first> 길동 </first> <last> 홍 </last> </name>
    <name> <first> 현아 </first> <last> 신 </last> </name>
    <name> <first> 나라 </first> <last> 장 </last> </name>
</simple>
~~~
1. DOMDocument를 생성하고, 그 아래에 root 노드를 만든다
   * root를 하나만 달아야 하기 때문에, append 함수를 쓰면 안된다
2. crate함수로 원하는 타입의 노드들을 만든다
3. 노드에 대한 관계를 추가하기 위해 appendChild 함수를 이용한다
4. documentElement는 쓰기 가능. 따라서, documentElementProperty에 접근.
---
## EX 7-7.
위의 코드 참고
---
## 9.3. 특정 Element의 Attribute 생성
~~~Javascript
xmldoc = new ActiveXObject("Msxml2.DOMDocument");
var root = xmldoc.createElement("root");
var text = xmldoc.createTextNode("Hello, My World!");
root.appendChild(text);

/*1. attribute 노드를 만든다*/
var attr = xmldoc.createAttribute("what");
/*2. attribute 값을 지정한다*/
attr.nodeValue = "message";
/*3. 특정 노드에 attribute를 추가한다. 여기서는 최상위 노드에 추가*/
root.attributes.setNamedItem(attr);
xmldoc.documentElement = root;
alert(xmldoc.xml);
~~~
### 9.3.1. 순서
1. attribute 노드를 만든다
2. attribute 값을 지정한다
3. 특정 노드에 attribute를 추가한다.
   * **attributes는 append로 붙이지 않는 것에 유의**