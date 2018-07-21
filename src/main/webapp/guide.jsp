<!DOCTYPE html>
<html>
<head>
  <title>CodeU Chat App</title>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="/css/main.css">
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">

</head>
<body>

  <nav>
    <a id="navTitle" href="/">CodeU Chat App</a>
    <a href="/conversations">Conversations</a>
    <% if(request.getSession().getAttribute("user") != null){ %>
      <a>Hello <%= request.getSession().getAttribute("user") %>!</a>
    <% } else{ %>
      <a href="/login">Login</a>
    <% } %>
    <a href="/about.jsp">About</a>
    <a href="/activity">Activity</a>
  </nav>

  <div id="container">
    <div
      style="width:75%; margin-left:auto; margin-right:auto; margin-top: 50px;">

      <h1>How to style your text on the CodeU Chat App</h1>
      <p>
        <ul>
          <li>Our chat app currently uses the BBCode markup language to allow users to syle their text. We currently do not allow HTML tags for text styling in order for our app to be as user friendly as possible. You can see the guide below that lists all the possible BBCode tags that you can use when starting a conversation on our chat app.</li>
          <li>Our chat app also allows emoji! You can access an emoji by simply typing in the emoji name enclosed by colons.
            <ul>
              <li>Example - :smile: would become &#X1F601;</li>
              <li>Can't figure out the name of the emoji that you want to use? <a href="https://www.webpagefx.com/tools/emoji-cheat-sheet/">Click here</a> for a cheat sheet!</li>
            </ul>
          </li>
        </ul>
      </p>
      <br>
            <table cellpadding = "15" cellspacing = "1" border="4">
              <tr>
                  <td><b>BBCODE</b></td>
                  <td><b>Output</b></td>
              </tr>
              <tr>
                  <td>[b]bolded text[/b]</td>
                  <td><b>Bolded Text</b></td>
              </tr>
              <tr>
                  <td>[i]italicized text[/i]</td>
                  <td><i>italicized text</i></td>
              </tr>
              <tr>
                  <td>[u]underlined text[/u]</td>
                  <td><u>underlined text</u></td>
              </tr>
              <tr>
                  <td>[s]strikethrough text[/s]</td>
                  <td><s>strikethrough text</s></td>
              </tr>
              <tr>
                  <td>[url]https://www.google.com/[/url] <br><br>or<br><br> just enter the link! (be sure to include https://)</td>
                  <td><a href="https://www.google.com/">https://www.google.com/</a></td>
              </tr>
              <tr>
                  <td>[url=https://www.google.com/]GOOGLE[/url]</td>
                  <td><a href="https://www.google.com/">GOOGLE</a></td>
              </tr>
              <tr>
                  <td>[img]https://tinyurl.com/y9cpmcor[/img]</td>
                  <td><img src="https://tinyurl.com/y9cpmcor" alt="" /></td>
              </tr>
              <tr>
                  <td>[color=red]LOOK AT ME![/color] <br><br>
                    or <br><br> [color=#FF0000]LOOK AT ME![/color]</td>
                  <td><span style="color:#FF0000;">LOOK AT ME!</span></td>
              </tr>
              <tr>
                  <td>[font=Comic Sans MS]Look at me![/font]</td>
                  <td><span style="font-family: Comic Sans MS">Look at me!</span> <br><br> To see supported fonts <a href="https://en.wikipedia.org/wiki/Font_family_(HTML)">click here!</a></td>
              </tr>
              <tr>
                  <td>[code]monospaced text[/code]</td>
                  <td><pre>monospaced text</pre></td>
              </tr>
              <tr>
                  <td>[list] <br> [*]Entry 1 <br> [*]Entry 2 <br> [/list] <br><br> or <br><br> [list] <br> *Entry 1 <br> *Entry 2 <br> [/list]</td>
                  <td><ul><li>Entry 1</li><li>Entry 2</li></ul></td>
              </tr>
              <tr>
                  <td>[table] <br> [tr] <br> [td]table 1[/td] <br> [td]table 2[/td] <br> [/tr] <br> [tr] <br> [td]table 3[/td] <br> [td]table 4[/td] <br> [/tr] <br> [/table]</td>
                  <td><table><tr><td>table 1</td><td>table 2</td></tr><tr><td>table 3</td><td>table 4</td>
                  </tr></table>
                  </td>
              </tr>
            </table>
    </div>
  </div>
</body>
</html>