## Censys Quota Refill 📡

### Description 📌
This simple script checks if the current quota in your [Censys](https://censys.com/) free account is reached (250 api calls/month) then it replaces the api key with one key with quota in the list.

### Setup ⚙️
- Register some Censys free accounts and copy the api keys in the script
- Run the script ```./censys-quota-refill.sh``` before using censys, so you can be sure you have quota
- The next month all your key will start again with 0 quota

### Dependences 📜
```pip install censys```
