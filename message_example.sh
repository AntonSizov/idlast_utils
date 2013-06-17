#!/bin/sh
# This gives an example of sending an HTML message.
#
(
echo "From: no-reply@idlast.com"
echo "To: a.sysoff@gmail.com"
echo "MIME-Version: 1.0"
echo "Content-Type: multipart/mixed;"
echo ' boundary="BOUNDARY"'
echo "Subject: Test Message"
echo ""
echo "This is a MIME-encapsulated message"
echo "--BOUNDARY"
echo "Content-Type: text/plain"
echo ""
echo "This is what someone would see without an HTML capable mail client."
echo ""
echo "--BOUNDARY"
echo "Content-Type: text/html"
echo ""
echo "<html>
<body bgcolor='black'>
<blockquote><font color='green'>GREEN</font> <font color='white'>WHITE</font> <font color='red'>RED</font></blockquote>
</body>
</html>"
echo "--BOUNDARY"
) | sendmail -t