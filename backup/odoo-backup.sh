cd /home/odoo-deployment/backup/
docker exec -it db pg_dump -U odoo dbname > dbname.sql
tar czvf "db_"`date +"%Y-%m-%d"`".tar.gz" dbname.sql
rm dbname.sql
rm "db_"`date --date="1 day ago" +"%Y-%m-%d"`".tar.gz"
docker exec -it --user root odoo tar -C /var/lib/odoo/filestore -czpvf /var/lib/odoo/filestore/"filestore_"`date +"%Y-%m-%d"`".tar.gz" dbname
docker exec -it --user root odoo rm /var/lib/odoo/filestore/"filestore_"`date --date="1 day ago" +"%Y-%m-%d"`".tar.gz"
docker cp odoo:/var/lib/odoo/filestore/"filestore_"`date +"%Y-%m-%d"`".tar.gz" .
rm "filestore_"`date --date="1 day ago" +"%Y-%m-%d"`".tar.gz"

