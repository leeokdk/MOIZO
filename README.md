# MOIZO
넥스트아이티 교육원 팀과제 
## server.xml 이슈
로컬에 파일을 저장하기 위해 톰캣 서버의 config 파일을 직접 수정함
Context docBase에 해당 구문 추가
<code><pre><#Context docBase="/home/pc14/upload" path="/img" reloadable="true"/></pre></code>
