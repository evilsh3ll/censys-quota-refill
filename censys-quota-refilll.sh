# PUT HERE YOUR FREE API CREDENTIALS
censys_api_list=(
	"API_ID:API_SECRET", # 250 calls each key
	"API_ID:API_SECRET",
	"API_ID:API_SECRET",
	"API_ID:API_SECRET",
)

# REFILL QUOTA FROM LIST
function check_censys_and_refill()
  curr_quota=$(censys account | grep "/" | awk '{print $5}')

  if [ "$curr_quota" -gt 249 ]; then
    # PRINT CURRENT QUOTA 
    email=$(censys account | grep "Email" | awk '{print $4}')
    echo "Censys [$email] limit quota reached: $curr_quota"
    
    for curr_api in "${censys_api_list[@]}"
    do	
        # GET AND REFILL NEW KEYS
    	  api_id=$(echo "$curr_api" | cut -d ':' -f 1)
          api_secret=$(echo "$curr_api" | cut -d ':' -f 2)
          sed -i "s/api_id =.*/api_id = $api_id/" ~/.config/censys/censys.cfg
          sed -i "s/api_secret =.*/api_secret = $api_secret/" ~/.config/censys/censys.cfg

        # PRINT NEW QUOTA
        new_quota=$(censys account | grep "/" | awk '{print $5}')
        if [ "$new_quota" -lt 250 ]; then
        	echo "Censys API switched - New Quota: $check"
        	return # EXIT IF THERE IS QUOTA
        fi
    done    
  fi
}

# LIST AVAILABLE QUOTA FOR ALL ACCOUNTS
function list_censys_api_quota() {
  for curr_api in "${censys_api_list[@]}"
  do
      api_id=$(echo "$curr_api" | cut -d ':' -f 1)
      api_secret=$(echo "$curr_api" | cut -d ':' -f 2)
      sed -i "s/api_id =.*/api_id = $api_id/" ~/.config/censys/censys.cfg
      sed -i "s/api_secret =.*/api_secret = $api_secret/" ~/.config/censys/censys.cfg
      p1=$(censys account | grep "/" | awk '{print $5}')
      p2=$(censys account | grep "/" | awk '{print $7}')
      email=$(censys account | grep "Email" | awk '{print $4}')
      echo "${email} reached ${p1}/${p2} quota"
  done   
}

# LIST QUOTA
list_censys_api_quota
# REFILL ACCOUNT IF NEEDED
check_censys_and_refill
