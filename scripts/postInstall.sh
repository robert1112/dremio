#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 60s;

target=$(docker-compose port dremio 9047)

timeStamp=$(echo '('`date +"%s.%N"` ' * 1000)/1' | bc)

  curl http://${target}/apiv2/bootstrap/firstuser \
  -X 'PUT' \
  -H 'accept: */*' \
  -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6' \
  -H 'authorization: null' \
  -H 'content-type: application/json' \
  -H 'cookie: fonce_current_session=1; fonce_current_day=1,undefined; fonce_current_user=1' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36' \
  --data-raw '{"userName":"admin","firstName":"admin","lastName":"admin","email":"'${ADMIN_EMAIL}'","createdAt":'${timeStamp}',"password":"'${ADMIN_PASSWORD}'","extra":null}' \
  --compressed