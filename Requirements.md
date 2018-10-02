# Requirements 
In this section you will create a web server using `wai` and `warp`
your server should respond to the following routes:
  * GET /
    * should return any kind of static content you like
  * GET /hello/$name
    * should return html saying "hello $name", where $name is a path parameter
  * requests for unknown routes should respond with a 404 status
  * GET /?numerator=$n1&denominator=$n2
    * should return an html page displaying the result of n1/n2

Once you have gotten your server behaving as expected, test it out in a browser
