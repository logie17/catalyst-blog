PRAGMA foreign_keys = ON;

CREATE TABLE entry (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(250),
    markup TEXT,
    html TEXT,
    post_date DATE,
    author INTEGER REFERENCES author(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE comment (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    comment TEXT,
    entry_id INTEGER REFERENCES entry(id) ON DELETE CASCADE ON UPDATE CASCADE,
);

CREATE TABLE author(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(250),
    last_name VARCHAR(250), 
    username VARCHAR(250), 
    password VARCHAR(250)
);

INSERT INTO "author" VALUES(1,'Logan',NULL,'logie','e10adc3949ba59abbe56e057f20f883e');

INSERT INTO "entry" VALUES(1,'What do you declare?','If you use the bash shell, if you run ''declare -f'', what sort of functions do you have? This is the first post in the series *What do you declare*, and I''ll post useful bash functions which I''ve accumulated over the years.

The first and probably the most useful function I have is *mygrep*. 

    function mygrep()
    {
        if [ $1 ]
        then
            find . -path ''*/.svn'' -prune -o -type f -exec grep -nHo "$1" ''{}'' \n;
        else
            echo "Error: Please supply argument"
        fi
    }   

','<p>If you use the bash shell, if you run ''declare -f'', what sort of functions do you have? This is the first post in the series <em>What do you declare</em>, and I''ll post useful bash functions which I''ve accumulated over the years.</p>

<p>The first and probably the most useful function I have is <em>mygrep</em>. </p>

<pre><code>function mygrep()
{
    if [ $1 ]
    then
        find . -path ''*/.svn'' -prune -o -type f -exec grep -nHo "$1" ''{}'' \n;
    else
        echo "Error: Please supply argument"
    fi
}
</code></pre>','05/03/2009','Logan');
INSERT INTO "entry" VALUES(2,'Erb & Bind','Lately I''ve been playing around with [Erb]("http://www.ruby-doc.org/stdlib/libdoc/erb/rdoc/classes/ERB.html"), the ruby templating system. Although I think it falls way short on the functionality of Template Toolkit or other more mature template systems, its elegance is derived from it''s simplicity. 
###Erb
First a little background, I cut my teeth with Template Toolkit, which still is one of the most powerful template systems created. Erb, although not nearly as feature rich, is the (as far as I understand it) official template engine used by [Rails]("http://www.rubyonrails.org") and other Ruby frameworks. How Erb works is simple. You create a template file, which in my case, is a file with HTML mark up. Within the template you can run ruby code and expressions. The tag mark up is pretty simple to understand, if you want to run ruby code you just enclose it in `<=%%=print ''Hello World'' %%>`. So I banged out some CSS, HTML, along with a ruby script utilizing [Blue Cloth]("http://www.deveiate.org/projects/BlueCloth/") to parse my [markdown.]("http://en.wikipedia.org/wiki/Markdown") Unfortunately Erb has no native import function, which is highly useful if you create a wrapper template and wish to import additional templates. An example would be: 
`<%= import(''articles.html'') %>` 

Import is just a method in an object that I passed to my Erb object. Articles.html is a listing of articles (so far two) that is included into my html template.  In fact I have an initialized object called Page which is where the "import" method called in my template lives. This is how class Page looks:

    class Page
        def initialize(template_path)
            @template_path = template_path
        end
        def import (file_name)
            return File.new(@template_path + file_name).read
        end
        def get_binding
          return binding()
        end
    end


###Binding Object
Now to the nitty gritty, binding... When one looks at the Page class, there is a method called get_binding that just returns binding(). Binding() is a kernel object which supplies context for methods like eval. In order to make methods available to be called from within your template you have to pass a "binding" object. This binding magic initially confused me, but with a little digging, I think I may have gotten to the point where I can describe it. This may make further sense with more examples, here is how I setup my template object and pass the binding object.

    page = Page.new(''./templates/'')
    rhtml = ERB.new(template)
    print cgi.header
    rhtml.run(page.get_binding)


Binding is a kernel object (Kernel.binding) that returns bindings (or context) when called. This this often used in conjunction with the eval method. In fact if you were to scour the source code for Erb you would send at the very end that eval is called along with the binding method. An example of binding/eval would be the following:

    class Test
        def initialize
            @test1 = ''test2''
        end
        def test_method
            return ''example 1''
        end
        def get_bind
            return binding()
        end
    end
    def test_method
        return ''example 2''
    end
    test_obj = Test.new()
    result = eval("test_method()",Test.binding) # Returns "example 1"
    puts results
    result = eval ("test_method()") # Returns "example 2"
    puts result


Notice that eval takes a second argument, and this second argument is for the Binding object. This object helps establish context for which method is going to be called. The key to this example is what eval returns. With context set to use Test.binding it executes the test_method within the context of Test.  

That''s a wrap, I hope someone may stumble upon this and perhaps find it interesting.

Cheers!

','<p>Lately I''ve been playing around with <a href=""http://www.ruby-doc.org/stdlib/libdoc/erb/rdoc/classes/ERB.html"">Erb</a>, the ruby templating system. Although I think it falls way short on the functionality of Template Toolkit or other more mature template systems, its elegance is derived from it''s simplicity. </p>

<h3>Erb</h3>

<p>First a little background, I cut my teeth with Template Toolkit, which still is one of the most powerful template systems created. Erb, although not nearly as feature rich, is the (as far as I understand it) official template engine used by <a href=""http://www.rubyonrails.org" title=") and other Ruby frameworks. How Erb works is simple. You create a template file, which in my case, is a file with HTML mark up. Within the template you can run ruby code and expressions. The tag mark up is pretty simple to understand, if you want to run ruby code you just enclose it in <code>&lt;=%%=print ''Hello World'' %%&gt;</code>. So I banged out some CSS, HTML, along with a ruby script utilizing [Blue Cloth](&quot;http://www.deveiate.org/projects/BlueCloth/">Rails</a> to parse my <a href=""http://en.wikipedia.org/wiki/Markdown"">markdown.</a> Unfortunately Erb has no native import function, which is highly useful if you create a wrapper template and wish to import additional templates. An example would be: 
<code>&lt;%= import(''articles.html'') %&gt;</code> </p>

<p>Import is just a method in an object that I passed to my Erb object. Articles.html is a listing of articles (so far two) that is included into my html template.  In fact I have an initialized object called Page which is where the "import" method called in my template lives. This is how class Page looks:</p>

<pre><code>class Page
    def initialize(template_path)
        @template_path = template_path
    end
    def import (file_name)
        return File.new(@template_path + file_name).read
    end
    def get_binding
      return binding()
    end
end
</code></pre>

<h3>Binding Object</h3>

<p>Now to the nitty gritty, binding... When one looks at the Page class, there is a method called get_binding that just returns binding(). Binding() is a kernel object which supplies context for methods like eval. In order to make methods available to be called from within your template you have to pass a "binding" object. This binding magic initially confused me, but with a little digging, I think I may have gotten to the point where I can describe it. This may make further sense with more examples, here is how I setup my template object and pass the binding object.</p>

<pre><code>page = Page.new(''./templates/'')
rhtml = ERB.new(template)
print cgi.header
rhtml.run(page.get_binding)
</code></pre>

<p>Binding is a kernel object (Kernel.binding) that returns bindings (or context) when called. This this often used in conjunction with the eval method. In fact if you were to scour the source code for Erb you would send at the very end that eval is called along with the binding method. An example of binding/eval would be the following:</p>

<pre><code>class Test
    def initialize
        @test1 = ''test2''
    end
    def test_method
        return ''example 1''
    end
    def get_bind
        return binding()
    end
end
def test_method
    return ''example 2''
end
test_obj = Test.new()
result = eval("test_method()",Test.binding) # Returns "example 1"
puts results
result = eval ("test_method()") # Returns "example 2"
puts result
</code></pre>

<p>Notice that eval takes a second argument, and this second argument is for the Binding object. This object helps establish context for which method is going to be called. The key to this example is what eval returns. With context set to use Test.binding it executes the test_method within the context of Test.  </p>

<p>That''s a wrap, I hope someone may stumble upon this and perhaps find it interesting.</p>

<p>Cheers!</p>','05/01/2009','Logan');
INSERT INTO "entry" VALUES(3,'Taskpaper.vim','I don''t know about you but my work day consists of working with random bits of paper with lists on them. As things come up I write it down on my scrap piece of paper and as I complete items I scratch it off the list. In this day of technology I could never find an electronic equivalent to keep track of all my lists. In some of my downtime I browse through vim plugins and I came across taskpaper.vim. This plugin replicates the functionality of the Mac application [TaskPaper]("http://www.hogbaysoftware.com/products/taskpaper").
###Keep it simple
Tasks are simple, and should be kept simple. The reason I''ve never been able to find an alternative to pen and paper is simply because most electronic alternatives are simply too complex. Taskpaper.vim has 4 simple mappings and adding a new task is as simple as firing up vim. Here is an example of taskpaper format:

    Todays Tasks:
    - Fix bug with search: @bugs
    - Migrate the code for project X: @projectx
    - Talk with Ted about my review: @done
    
    The Special Project:
    - Develop UI: @done
    - QA: @todo
    - Deploy: @todo

As you can see this file is relatively simple and easy to read. Projects are distinguished with text followed by the colon, ":", and tasks begin with a dash -. The @, at sign, allow for tags on each task. There can be multiple tags per task.

The new mappings which I mentioned are the following: *\td*, *\tc*, *\tp*, and *\ta*. *\td* marks a task as done, this will add the tag @done to your task. *\tc* will show all tasks that are have the same tag. *\tp* will fold all projects and *\ta* will show all projects and tasks. 

Finally I created some shortcuts in my .vimrc file to make things a little simpler. 

    $tasks = $HOME . ''/tasks/logans_tasks.taskpaper''
    nmap <C-t> :tabnew $tasks<CR>

Now whenever I press *CTRL-T* a new tab will open with my taskpaper tasks!

It simply is cool.

','<p>I don''t know about you but my work day consists of working with random bits of paper with lists on them. As things come up I write it down on my scrap piece of paper and as I complete items I scratch it off the list. In this day of technology I could never find an electronic equivalent to keep track of all my lists. In some of my downtime I browse through vim plugins and I came across taskpaper.vim. This plugin replicates the functionality of the Mac application <a href="http://www.hogbaysoftware.com/products/taskpaper">TaskPaper</a>.</p>

<h3>Keep it simple</h3>

<p>Tasks are simple, and should be kept simple. The reason I''ve never been able to find an alternative to pen and paper is simply because most electronic alternatives are simply too complex. Taskpaper.vim has 4 simple mappings and adding a new task is as simple as firing up vim. Here is an example of taskpaper format:</p>

<pre><code>Todays Tasks:
- Fix bug with search: @bugs
- Migrate the code for project X: @projectx
- Talk with Ted about my review: @done

The Special Project:
- Develop UI: @done
- QA: @todo
- Deploy: @todo
</code></pre>

<p>As you can see this file is relatively simple and easy to read. Projects are distinguished with text followed by the colon, ":", and tasks begin with a dash -. The @, at sign, allow for tags on each task. There can be multiple tags per task.</p>

<p>The new mappings which I mentioned are the following: <em>\td</em>, <em>\tc</em>, <em>\tp</em>, and <em>\ta</em>. <em>\td</em> marks a task as done, this will add the tag @done to your task. <em>\tc</em> will show all tasks that are have the same tag. <em>\tp</em> will fold all projects and <em>\ta</em> will show all projects and tasks. </p>

<p>Finally I created some shortcuts in my .vimrc file to make things a little simpler. </p>

<pre><code>$tasks = $HOME . ''/tasks/logans_tasks.taskpaper''
nmap &lt;C-t&gt; :tabnew $tasks&lt;CR&gt;
</code></pre>

<p>Now whenever I press <em>CTRL-T</em> a new tab will open with my taskpaper tasks!</p>

<p>It simply is cool.</p>','05/02/2009','Logan');
INSERT INTO "entry" VALUES(4,'Xargs Frakin Rocks','I''m not a unix sys admin, but I remember the day I discovered xargs and the sheer power I felt. Xargs gave me the ability to run any command on any piped list of files. 

For example: 

    ls filenames

This would output your list of files. Now lets say you want to cat each file name. With xargs this is as simple as the following:

    ls filenames | xargs cat

###Advanced Usage 

Now lets say you have a more complex command, such as a command with arguments. For example lets say you want to take a list of filenames and use perl to search and replace tokens within the files.

    ls filenames | xargs -I {} perl -pi -e ''s/foo/bar/'' {}

Essentially the I flag tells xargs to use a replace string, that string being the opening/closing curly braces. Whenever this string is used in the command the filename will appear here. Really the command being executed over and over by xargs is 
    perl -pi -e ''s/foo/bar/ filename

With great power comes a great responsbility, go forth and do good.

','<p>I''m not a unix sys admin, but I remember the day I discovered xargs and the sheer power I felt. Xargs gave me the ability to run any command on any piped list of files. </p>

<p>For example: </p>

<pre><code>ls filenames
</code></pre>

<p>This would output your list of files. Now lets say you want to cat each file name. With xargs this is as simple as the following:</p>

<pre><code>ls filenames | xargs cat
</code></pre>

<h3>Advanced Usage</h3>

<p>Now lets say you have a more complex command, such as a command with arguments. For example lets say you want to take a list of filenames and use perl to search and replace tokens within the files.</p>

<pre><code>ls filenames | xargs -I {} perl -pi -e ''s/foo/bar/'' {}
</code></pre>

<p>Essentially the I flag tells xargs to use a replace string, that string being the opening/closing curly braces. Whenever this string is used in the command the filename will appear here. Really the command being executed over and over by xargs is 
    perl -pi -e ''s/foo/bar/ filename</p>

<p>With great power comes a great responsbility, go forth and do good.</p>','06/03/2009','Logan');
INSERT INTO "entry" VALUES(5,'FizzBuzz','Back in 2007, [Jeff Atwood](http://www.codinghorror.com), posted a blog entry title [Why Can''t Programmers..Program?](http://www.codinghorror.com/blog/archives/000781.html). In this posting was a diatribe on claimed skill sets of programmer applicants and their actual ability to program "their way out of a paper bag". Quoting from various other bloggers it seems at the program [FizzBuzz](http://en.wikipedia.org/wiki/FizzBuzz) is a common screening tool by interviewers to separate the wheat from the chaff.  He quotes [Dan Kegal](http://www.kegel.com/) saying "you''re already ahead of the pack" if you can demonstrate some proficiency solving "real problems" with recursion. 

So I thought I would give a go at creating some basic FizzBuzz examples in a handful of the languages that I''m familiar with. These are just basic examples, nothing very fancy but they demonstrate an understanding of the problem and they use recursion. 

*Perl*

    #!/usr/bin/perl 
    
    use strict;
    use warnings;
    
    
    sub fizz_buzz
    {
        my $count = shift;
        return if $count == 0;
        fizz_buzz($count-1);
        print "$count-Fizz\n" if $count % 3 == 0;
        print "$count-Buzz\n" if $count % 5 == 0;
        print "$count-FizzBuzz\n" if $count % 5 == 0 && $count % 3 == 0;
    }
    
    fizz_buzz(100);

*C++*

    #include <iostream>
    
    using namespace std;
    
    void fizzbuzz(int);
    
    int main()
    {
        fizzbuzz(100);
    }
    
    void fizzbuzz(int count)
    {
        if (count == 0)
            return;
        fizzbuzz(count-1);
        if (count % 3 == 0 )
            cout << count << "-Fizz" << endl;
        if (count % 5 == 0 )
            cout << count << "-Buzz" << endl;
        if (count % 3 == 0 && count % 5 == 0 )
            cout << count << "-FizzBuzz" << endl;
    }

*Bash*

    #! /bin/bash
    
    function fizzbuzz
    {
        count=1    
    
        while [ $count -le 100 ] 
        do
            let mod3=$count%3
            let mod5=$count%5
            if [ [ $mod3 -eq 0 ]]; then
                echo "$count - Fizz";
            fi
            if [ $mod5 -eq 0 ]; then
                echo "$count - Buzz";
            fi
            if [[ $mod3 -eq 0 && $mod5 -eq 0 ]]; then
                echo "$count - FizzBuzz";
            fi
            let "count+=1";
        done 
    }
    
    fizzbuzz 

*Ruby - Both recursive and rubyish ways*

    #! /usr/bin/ruby
    
    def fizzbuzz(count)
        return if count == 0;
        fizzbuzz(count-1);
        print "#{count} -Fizz\n" if count % 3 == 0;
        print "#{count} -Buzz\n" if count % 5 == 0;
        print "#{count} -FizzBuzz\n" if count % 5 == 0 && count % 3 == 0;
    end
    
    fizzbuzz(100)
    
    (1..100).each do|count|
        print "#{count} -Fizz\n" if count % 3 == 0;
        print "#{count} -Buzz\n" if count % 5 == 0;
        print "#{count} -FizzBuzz\n" if count % 5 == 0 && count % 3 == 0;
    end

Feel free to download the [source](/downloads/fizzbuzz.zip) and please I can accept both check and cash for my signing bonus. :) 
','<p>Back in 2007, <a href="http://www.codinghorror.com">Jeff Atwood</a>, posted a blog entry title <a href="http://www.codinghorror.com/blog/archives/000781.html">Why Can''t Programmers..Program?</a>. In this posting was a diatribe on claimed skill sets of programmer applicants and their actual ability to program "their way out of a paper bag". Quoting from various other bloggers it seems at the program <a href="http://en.wikipedia.org/wiki/FizzBuzz">FizzBuzz</a> is a common screening tool by interviewers to separate the wheat from the chaff.  He quotes <a href="http://www.kegel.com/">Dan Kegal</a> saying "you''re already ahead of the pack" if you can demonstrate some proficiency solving "real problems" with recursion. </p>

<p>So I thought I would give a go at creating some basic FizzBuzz examples in a handful of the languages that I''m familiar with. These are just basic examples, nothing very fancy but they demonstrate an understanding of the problem and they use recursion. </p>

<p><em>Perl</em></p>

<pre><code>#!/usr/bin/perl 

use strict;
use warnings;


sub fizz_buzz
{
    my $count = shift;
    return if $count == 0;
    fizz_buzz($count-1);
    print "$count-Fizz\n" if $count % 3 == 0;
    print "$count-Buzz\n" if $count % 5 == 0;
    print "$count-FizzBuzz\n" if $count % 5 == 0 &amp;&amp; $count % 3 == 0;
}

fizz_buzz(100);
</code></pre>

<p><em>C++</em></p>

<pre><code>#include &lt;iostream&gt;

using namespace std;

void fizzbuzz(int);

int main()
{
    fizzbuzz(100);
}

void fizzbuzz(int count)
{
    if (count == 0)
        return;
    fizzbuzz(count-1);
    if (count % 3 == 0 )
        cout &lt;&lt; count &lt;&lt; "-Fizz" &lt;&lt; endl;
    if (count % 5 == 0 )
        cout &lt;&lt; count &lt;&lt; "-Buzz" &lt;&lt; endl;
    if (count % 3 == 0 &amp;&amp; count % 5 == 0 )
        cout &lt;&lt; count &lt;&lt; "-FizzBuzz" &lt;&lt; endl;
}
</code></pre>

<p><em>Bash</em></p>

<pre><code>#! /bin/bash

function fizzbuzz
{
    count=1    

    while [ $count -le 100 ] 
    do
        let mod3=$count%3
        let mod5=$count%5
        if [ [ $mod3 -eq 0 ]]; then
            echo "$count - Fizz";
        fi
        if [ $mod5 -eq 0 ]; then
            echo "$count - Buzz";
        fi
        if [[ $mod3 -eq 0 &amp;&amp; $mod5 -eq 0 ]]; then
            echo "$count - FizzBuzz";
        fi
        let "count+=1";
    done 
}

fizzbuzz
</code></pre>

<p><em>Ruby - Both recursive and rubyish ways</em></p>

<pre><code>#! /usr/bin/ruby

def fizzbuzz(count)
    return if count == 0;
    fizzbuzz(count-1);
    print "#{count} -Fizz\n" if count % 3 == 0;
    print "#{count} -Buzz\n" if count % 5 == 0;
    print "#{count} -FizzBuzz\n" if count % 5 == 0 &amp;&amp; count % 3 == 0;
end

fizzbuzz(100)

(1..100).each do|count|
    print "#{count} -Fizz\n" if count % 3 == 0;
    print "#{count} -Buzz\n" if count % 5 == 0;
    print "#{count} -FizzBuzz\n" if count % 5 == 0 &amp;&amp; count % 3 == 0;
end
</code></pre>

<p>Feel free to download the <a href="/downloads/fizzbuzz.zip">source</a> and please I can accept both check and cash for my signing bonus. :) </p>','06/16/2009','Logan');
INSERT INTO "entry" VALUES(6,'LogTris','In my attempts to fully understand JavaScript, I decided to write and implement a game. I thought [tetris](/projects/tetris) might be a good start. It is a pretty buggy implementation but it works for the most part. My version is dubbed [LogTris](/projects/tetris).



','<p>In my attempts to fully understand JavaScript, I decided to write and implement a game. I thought <a href="/projects/tetris">tetris</a> might be a good start. It is a pretty buggy implementation but it works for the most part. My version is dubbed <a href="/projects/tetris">LogTris</a>.</p>','06/20/2009','Logan');



