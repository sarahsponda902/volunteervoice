<%
' get the querystring value
qsFn = Trim(Request.QueryString("fn"))

' add your server side validation here
' this just checks for an empty string
If qsFn <> "" Then
	' add your connection string here
	strConn = ""
	
	' you should use a stored procedure or a parameterized query to defend against sql injection
	' I'll use a dynamic sql query to keep it simple. NOT recommended!
	SQL = "SELECT Id FROM youruserstable WHERE Username = '" & qsFn & "'"
	
	' execute the query
	Set objConn = Server.CreateObject("ADODB.Connection")
	objConn.Open strConn
	Set objRS = objConn.Execute
	
	If NOT objRS.EOF Then
		' if the username is not found
		' this is the message that's displayed to the user
		Response.Write("Username NOT available")
	Else
		' if the username is found
		' this is the message that's displayed to the user
		Response.Write("Username available")
	End If
	objRS.Close: Set objRS = Nothing: objConn.Close
Else
	' no value was passed in the querystring
	' so display this error message
	Response.Write("Please enter a value.")
End If
%>