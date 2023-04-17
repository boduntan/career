$DBNAME="career_search"
DBEXISTS=$(mysql --batch --skip-column-names -e "SHOW DATABASES LIKE '"$DBNAME"';" | grep "$DBNAME" > /dev/null; echo "$?")
if [ $DBEXISTS -eq 0 ]
then
    echo "A database with the name $DBNAME already exists. exiting"
else
    echo "no db, create"
    sudo mysql < /var/www/html/database/career_search.sql
fi