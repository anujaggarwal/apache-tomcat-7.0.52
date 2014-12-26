@echo off

rem ---------------------------------------------------------------------------
rem Restart script for the CATALINA Server
rem ---------------------------------------------------------------------------

cls

rem Store current directory
set "CURRENT_DIR=%cd%"

rem shutdown Tomcat first
call shutdown.bat

rem delete previously deployed webapp


call mvn install

echo Overwrite the freshly built WAR file to the Tomcat Webapps folder
copy /Y "%1" "%CATALINA_HOME%\webapps"

echo Goto Tomcat Webapps Folder
cd "%CATALINA_HOME%\webapps"

echo Delete the deployed webapp folder from the Tomcat Webapps folder
rem %~n1 Expand %1 to a file Name without file extension C:\utils\MyFile or if only a path is present (with no trailing backslash\) - the last folder in that path.
echo "%~n1"
rmdir /s /q "%~n1"
echo Delete ROOT folder if there
rmdir /s /q ROOT

echo Delete the deployed webapp folder from the apache-tomcat-7.0.52\work\Catalina\localhost as well...
cd ..\work\Catalina\localhost\
echo "%~n1"
rmdir /s /q "%~n1"

rem Come back to the original directory
cd "%CURRENT_DIR%"

rem Start Tomcat
call startup.bat
