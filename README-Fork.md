This is forked code from exoplayer
we are keeping a seperate forked-release branch to use in our products,
whenever exoplayer releases a new version we will update this branch

Version Releases ChangeLog
--------

1.8.0-2

Added more flexible support for device capability check


Module releases to github 
------------------------

Run publish.sh file to publish all the modules to github, replace github username and token in the script
with your own github username and token

Version System
--------------

we are using a version system to keep track of the versions of the modules, and appending/increase 

last number whenever we make a change to anymodule and publish it to github
eg : If original version number is 1.8.0, then after making a change to any module we will increase the last number to 1.8.0-1 and publish it to github


Direct usage of modules
----------------

add the following in settings files 

```

includeBuild("../media3-fork") {
    dependencySubstitution {
        substitute(module("com.streamotion.media3:media3-exoplayer")).using(project(":lib-exoplayer"))
        substitute(module("com.streamotion.media3:media3-exoplayer-dash")).using(project(":lib-exoplayer-dash"))
        substitute(module("com.streamotion.media3:media3-exoplayer-hls")).using(project(":lib-exoplayer-hls"))
        substitute(module("com.streamotion.media3:media3-exoplayer-smoothstreaming")).using(project(":lib-exoplayer-smoothstreaming"))
        substitute(module("com.streamotion.media3:media3-ui")).using(project(":lib-ui"))
        substitute(module("com.streamotion.media3:media3-cast")).using(project(":lib-cast"))
        substitute(module("com.streamotion.media3:media3-datasource")).using(project(":lib-datasource"))
        substitute(module("com.streamotion.media3:media3-datasource-okhttp")).using(project(":lib-datasource-okhttp"))
        substitute(module("com.streamotion.media3:media3-common")).using(project(":lib-common"))
        substitute(module("com.streamotion.media3:media3-ui")).using(project(":lib-ui"))
    }
}
```


