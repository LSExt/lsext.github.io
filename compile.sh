hugo --gc --minify --baseURL "https://lsext.org/" && 
(cd public && tar -zcvf ../www-lsext-org.tar.gz . )
