my_username='seltecqa01'
my_password='Seltec2020'
my_host_num='3'
debug_lvl=2
docker build -t bala-noip .
echo -e "$(crontab -l)"$'\n'"12  3  *  *  1,3,5  docker run --network host bala-noip ${my_username} ${my_password} ${my_host_num} ${debug_lvl}" | crontab -