# kawpow-coins-mining-pool

![frontend](https://github.com/cristianvsl/kawpow-coins-mining-pool/assets/74607759/08e99225-a5bf-47c0-9ad0-305ba4f8fdf0)
<br>
![get-started](https://github.com/cristianvsl/kawpow-coins-mining-pool/assets/74607759/220b2475-263d-4b15-85b1-568135b1ea4b)
<br>
![pool-blocks](https://github.com/cristianvsl/kawpow-coins-mining-pool/assets/74607759/8e3bb090-2732-4093-b5da-7a48e2a4d7a7)
<br>
![pool-payments](https://github.com/cristianvsl/kawpow-coins-mining-pool/assets/74607759/52e13402-39a5-4953-ae08-53f7e7e4ddf0)
<br>

# Using Ubuntu 22.04 LTS

<b>If you are under "root" user:</b>

$ adduser pool

$ usermod -aG sudo pool

$ su - pool

$ sudo apt update && sudo apt upgrade -y

# Cloning

<b>What we are doing is cloning the master branch of the Satoxcoin node onto our computer in the src directory.</b>

$ mkdir src

$ cd src

$ git clone https://github.com/satoverse/satoxcoin.git

$ cd satoxcoin

<b>Next, once we have the source code for the node, we can start the process of building it. We need some dependencies/tools installed first so we can compile it. Run the following one long command to install what we need:</b>

$ sudo apt install -y libboost-chrono1.74-dev libboost-filesystem1.74-dev libboost-program-options1.74-dev libboost-system1.74-dev libboost-thread1.74-dev libboost-test1.74-dev build-essential libssl-dev qtbase5-dev qttools5-dev bison libexpat1-dev libdbus-1-dev libfontconfig-dev libfreetype-dev libice-dev libsm-dev libx11-dev libxau-dev libxext-dev libevent-dev libxcb1-dev libxkbcommon-dev libminiupnpc-dev libprotobuf-dev libqrencode-dev xcb-proto x11proto-xext-dev x11proto-dev xtrans-dev zlib1g-dev libczmq-dev autoconf automake libtool protobuf-compiler

# Compiling

<b>We need Berkeley DB for the node to run. Make sure you are in the directory "satoxcoin" (/home/$USER/satoxcoin)</b>

$ sudo chmod +x contrib/install_db4.sh

$ sudo chmod +x autogen.sh run.sh

$ sudo chmod +x share/genbuild.sh

$ contrib/install_db4.sh ../

$ wget https://gist.githubusercontent.com/darosior/a5d93c6245a32f7a8bed2ac4e33a0011/raw/89c49515febbd55ffb60e4add9d08f299862cde4/install_libdb4.8.sh

$ sudo chmod +x install_libdb4.8.sh

$ sudo ./install_libdb4.8.sh amd64  -  [This will install libdb4.8]

$ ./autogen.sh

$ export BDB_PREFIX='/home/$USER/src/db4'  -  [Swap out $USER for your user if you have issues.]

$ ./configure BDB_LIBS="-L${BDB_PREFIX}/lib -ldb_cxx-4.8" BDB_CFLAGS="-I${BDB_PREFIX}/include" --prefix=/usr/local

$ snap install bitcoin-core  -  [If you do not have "snap" installed, can be installed by runing: <b>sudo apt install snapd</b>]

$ make -j8 [ -j represents the number of your CPU cores ]

# After that completes, we need to run this command to install it into our /usr/local/bin folder so we can run it anywhere:

$ sudo make install

# Configuring the Node.

<b>Type cd to move to your $HOME directory</b>

$ python3 ~/src/Ravencoin/share/rpcuser/rpcuser.py $USER  -  [ Change $USER with any username you`d like to use as login credentials for the node. This credentials will be later used when building the mining pool for Satoxcoin]

The above command will spit out something like this:

<b>rpcauth=kritch:83701465552JKCHKJCH81d4ea5AUTHAUTHAUTHAUTHKHFlkfhkjdhfjkdh49bc49705</b>

<b>Your password:</b>

<b>sEjkdhPASSPASSPASS-JYisXKJGHXKGXKJH-u3vUM=</b>

Save the above somewhere safe and accesible for you as you`ll need these later.

Next, make sure you are in your $HOME directory. If you are not sure just type cd and press enter.

$ mkdir .satoxcoin

$ cd .satoxcoin

# Create the config file for the node

$ nano satoxcoin.conf

[In this file add the following and after, the only thing you need to change is your WALLET and NOTHING ELSE unless you know what you are doing]

#RPC authorization - generate this 
#rpcauth=kritch:LALALALALALAyourauthcodeLALALA

#Your address to receive any tokens - change to yours

miningaddress=YOURWALLET
#[This can be generated later after the node is synced with the following command: satoxcoin-cli getnewaddress]

#add a comment to your node info - PUT IN YOUR wallet address

uacomment=YOURWALLET

#debug - 1 means all

#debug=1

#Use BIP44 or not

bip44=1

#use only ipv4 - default is all - ipv4/ipv6/onion

#onlynet=ipv4

#listen for incoming connections

listen=1

#check mempool every 100 tx

checkmempool=100

#max memory used ion MB (300 default)

maxmempool=800

#specify the most connections you will make;  more = more memory

maxconnections=500

#Set database cache size in megabytes (450mb default)

dbcache=800

#run as a server & accept RPC commands

server=1

#use upnp if you don't have port 8767 open on your router

upnp=0

#pay for fees when sending assets.  More likely to be done fast.

#paytxfee=0.01

#or

#Create transactions that have enough fees so they are likely to begin confirmation within n blocks (default: 6).

txconfirmtarget=5

#Warning: Reverting pruning requires re-downloading the entire blockchain.

#(default: 0 = disable pruning blocks, 1 = allow manual pruning via RPC, >550

#= automatically prune block files to stay under the specified target size in 
#MiB)

prune=0

txindex=1

#Run on the test network instead of the real satoxcoin network.

#testnet=0

#Run a regression test network

#regtest=0

#Connect via a SOCKS5 proxy

#proxy=127.0.0.1:9050

#Bind to given address and always listen on it. Use [host]:port notation for IPv6

#bind=<addr>

#Bind to given address and whitelist peers connecting to it. Use [host]:port notation for IPv6

#whitebind=<addr>

#Use as many addnode= settings as you like to connect to specific peers

addnode=182.70.4.247:60777

addnode=192.181.197.159:60777

addnode=192.99.32.68:60777

addnode=206.255.78.214:60777

addnode=208.87.206.172:60777 

addnode=211.229.148.72:60777

addnode=23.245.100.50:60777

addnode=24.115.249.51:60777

addnode=45.79.40.6:60777

addnode=46.101.186.35:60777

addnode=5.78.45.175:60777

addnode=83.44.212.48:60777

addnode=95.216.18.84:60777

addnode=[2001:b011:5c08:fab2:546e:45a0:a8a3:d4c8]:60777

addnode=[2001:fb1:14d:1c30:199e:3516:4072:a428]:60777

addnode=[2a01:4f9:2a:128b::2]:60777

addnode=[2a01:4ff:1f0:e3e7::1]:60777

addnode=[2a01:827:2278:f501:2591:d7a3:6d3a:2fa2]:60777


#Alternatively use as many connect= settings as you like to connect ONLY to specific peers

#connect=69.164.218.197:8767

#Bind to given address to listen for JSON-RPC connections. Use [host]:port notation for IPv6.

#This option can be specified multiple times (default: bind to all interfaces)

#rpcbind=<addr>

rpcuser=YOUR_USERNAME

rpcpassword=GENERATED_PASSWORD_WITH_COMMAND_python3 ~/src/satoxcoincoin/share/rpcuser/rpcuser.py $USER

#How many seconds satoxcoin will wait for a complete RPC HTTP request.

#after the HTTP connection is established.

#rpcclienttimeout=30

#NOTE: opening up the RPC port to hosts outside your local trusted network is NOT RECOMMENDED,

#because the rpcpassword is transmitted over the network unencrypted.

#rpcallowip=10.1.1.34/255.255.255.0

#rpcallowip=1.2.3.4/24

#rpcallowip=2001:db8:85a3:0:0:8a2e:370:7334/96

#Listen for RPC connections on this TCP port:

rpcport=7777

#You can use satoxcoin or satoxcoind to send commands to satoxcoin/satoxcoind

#running on another host using this option:

#rpcconnect=127.0.0.1

#Miscellaneous options

#Pre-generate this many public/private key pairs, so wallet backups will be valid for

#both prior transactions and several dozen future transactions.

#keypool=100


#User interface options

#Start satoxcoin minimized

#min=1

#Minimize to the system tray

#minimizetotray=1

<b>After you added the above to "satoxcoin.conf", save it: CTRL + x then type Y and ENTER.</b>

# Starting the Satocoin node.

$ satoxcoind -upgradewallet -debug=1 -printtoconsole

<b>This will start our Satoxcoin node and start connecting to other peers! It will be spitting out a ton of debug info and printing to the screen so you can make sure it is running. We just wanted to make sure it starts so we know it worked before proceeding. Let it run for a min or so & then to stop ravend, either hit CTRL-C on the keyboard, or preferred, in a different command terminal type "satoxcoin-cli stop".</b>

<b>The first time you really run it, it will take a hour or four to get to the point its done syncing & running the blockchain. It is also creating all our other files we need to run under the .satoxcoin directory. Lets get it so it starts itself on boot.</b>

<b>We need to create a service in Ubuntu that we will use to handle the starting/stoping of our node.</b>

$ sudo systemctl --force --full edit satoxnode  -  [satoxnode will be the name of the service]

After the above command, a file will open. Add the following into that file:

####################################################################################################

[Unit]

Description=SatoxCoin Blockchain

After=network-online.target

[Service]

User=REPLACEUSER

Group=REPLACEUSER

Type=simple

PIDFile=/home/REPLACEUSER/.satoxcoin/satoxcoin.pid

ExecStart=satoxcoind

Restart=always

TimeoutStopSec=60s

TimeoutStartSec=20s

StartLimitInterval=60

StartLimitBurst=5

[Install]

WantedBy=multi-user.target

####################################################################################################

You MUST replace the REPLACEUSER a total of 3 times here with your username you have installed this under. We can't use the wildcard cause it will be a system process. What this is telling the computer is to start the satoxcoin node after the network comes online and runs in the background.

Now hit CTRL-X and type yes, and hit enter to keep the default save location. We now have our service created! To enable it to start automatically on boot:

$ sudo systemctl enable satoxnode

<b>To manually start/top the node, type:</b>

$ sudo systemctl start satoxnode

$ sudo systemctl stop satoxnode

<b>To check the status of the node, type:</b>

$ sudo systemctl status satoxnode

<b>To check the sync progress, type:</b>

$ satoxcoin-cli getblockchaininfo

# Interacting with Satoxcoin Node

<b>We satoxcoin-cli to control/interact with Satoxcoin Node. All commands start with "satoxcoin-cli"</b>

<b>Here is the command that will return the network status:</b>

$ satoxcoin-cli getnetworkinfo

<b>Here is how to get blockchain sync info:</b>

$ satoxcoin-cli getblockchaininfo

<b>Here are more commands to help you work with satoxcoin with descriptions:</b>

# Blockchain Commands:

$ satoxcoin-cli getblockcount   #return block count

$ satoxcoin-cli getmempoolinfo   #returns memory info

$ satoxcoin-cli getdifficulty   #return difficulty

$ satoxcoin-cli getchaintxstats   #returns transaction stats

$ satoxcoin-cli abandontransaction "txid"   #cancel a transaction

$ satoxcoin-cli pruneblockchain   #deletes old blocks for space

# Wallet Commands:

$ satoxcoin-cli listwallets   #lists wallets open

$ satoxcoin-cli listaccounts   #list accounts under wallet

$ satoxcoin-cli getwalletinfo   #returns summary wallet info

$ satoxcoin-cli getbalance "walletAddress"   #returns specific wallet balance 

$ satoxcoin-cli getunconfirmedbalance   #returns pending balance

$ satoxcoin-cli getaddressesbyaccount "accountName"   #returns SATOX address

$ satoxcoin-cli validateaddress "walletAddress"   #verifies address

$ satoxcoin-cli getaccountaddress "accountName"   #gets a new SATOX address

$ satoxcoin-cli backupwallet "destination"  #makes copy of wallet

$ satoxcoin-cli dumpprivkey "walletAddress"   #retrieves private key

$ satoxcoin-cli importprivkey "privkey" ( "label" ) ( rescan )   #import pvt key

$ satoxcoin-cli importpubkey "pubkey" ( "label" rescan )   #import pub key

$ satoxcoin-cli importaddress "address" ( "label" rescan p2sh )   #import address

$ satoxcoin-cli mnemonic "your words"    #space separated list of 12-words to import

$ satoxcoin-cli mnemonicpassphrase "password"  #secures your 12-word mnemonic word

$ satoxcoin-cli getmywords # retrieve your BIP44 words

$ satoxcoin-cli encryptwallet "passphrase"   #encrypts wallet with passphrase

$ satoxcoin-cli listaddressgroupings   #shows accounts with balances

$ satoxcoin-cli listassetbalancesbyaddress "address"   #returns assets for wallet

$ satoxcoin-cli move "fromaccount" "toaccount" amount  #send between *accounts*

$ satoxcoin-cli sendfrom "fromaccount" "toaddress" amount  #send to different wallet

# Network Commands:

$ satoxcoin-cli getpeerinfo    #returns connected peers and stats

$ satoxcoin-cli getconnectioncount   #returns count of peers

$ satoxcoin-cli getnettotals    #returns data totals

$ satoxcoin-cli getnetworkinfo    #returns network status

$ satoxcoin-cli setnetworkactive "true|false"   #turns on/off networking

<b>You need a wallet so here is how you go about getting your wallet address and creating new ones. After satoxnode is started and synced:</b>

$ satoxcoin-cli getaccountaddress "accountName"

<b>It will return your wallet address for the new account in your wallet you just created!</b>

<b>Lets see it added now to our account account list:</b>

$ satoxcoin-cli listaccounts

or

$ satoxcoin-cli listaddressgroupings

<b>That will list the accounts you have setup and their balances in that current wallet.</b>

<b>For a list of your transactions, put in your account you want to audit and it will return a list of them:</b>

$ satoxcoin-cli listtransactions "account"

<b>Wanna move between the accounts in your wallet?</b>

$ satoxcoin-cli move "fromaccount" "toaccount" amount

<b>If it is successful it will return true.</b>

<b>Send money to someones wallet? Note,it is your account to send from, not wallet.</b>

$ satoxcoin-cli sendfrom "fromaccount" "toaddress" amount

<b>It will return your TX hash if successful.</b>

# Building the mining pool and website


<b>Make sure you are in your $HOME directory.</b>

$ git clone https://github.com/cristianvsl/kawpow-coins-mining-pool.git

$ cd kawpow-coins-mining-pool

<b> You`ll need NodeJS v12.22.12. You can installit via NVM (Node Version Manager)</b>

$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash  -  [After installation is complete, close and reopen your terminal]

<b>As the Node Version Manager is now installed, we can proceed with the nodejs installation</b>

$ nvm install 12.22.12  -  [This will install the nodejs v12.22.12. If you need to see a list of other versions of node, type: "nvm ls-remote"]

<b>Now. Make sure you are in the /kawpow-mining-pool/ directory</b>

$ nano config.json  

[Under the <b>"website": {</b> module, change the <b>"host": "138.68.178.118",</b> with your IP Address and under <b>"stratumHost": "satox.miningpub.co.uk",</b> change it to your pool web address.

<b>Also, change "sslenabled" and "sslforced" to <i>false</i>. If you plan having SSL on your website, these can be changed later.</b>

<b>Pool config file, which can be found under the <i>pools</i> directory. The file name is: satoxcoin.json</b>

Open it with "nano" or your favourite text editing and change "address", "donateaddress" and "rewardRecipients" with your Satoxcoin address generated earlier with "satoxcoin-cli getnewaddress".

In the same file,

    "paymentProcessing": {
    
        "enabled": true,
        
        "schema": "PROP",
        
        "paymentInterval": 120,
        
        "minimumPayment": 5,
        
        "maxBlocksPerPayment": 50000,
        
        "minConf": 120,
        
        "coinPrecision": 8,
        
        "daemon": {
        
            "host": "127.0.0.1",
            
            "port": 7777,
            
            "user": "pool",  -  [Change this with your USER created earlier with the command "python3 ~/src/Ravencoin/share/rpcuser/rpcuser.py $USER"]
            
            "password": "password"  -  [Change this with your password generated earlier with the command "python3 ~/src/Ravencoin/share/rpcuser/rpcuser.py $USER"]

<b>In the same satoxcoin.json file,</b>

    "daemons": [
        {
            "host": "127.0.0.1",
            "port": 7777,
            "user": "pool",  -  [Change this with your USER created earlier with the command "python3 ~/src/Ravencoin/share/rpcuser/rpcuser.py $USER"]
            "password": "password"  -  [Change this with your password generated earlier with the command "python3 ~/src/Ravencoin/share/rpcuser/rpcuser.py $USER"]

<b>If you done everything correctly and the node is synced, you are ready to start the pool.</b>

<b>In the pool folder (/home/$USER/kawpow-coins-mining-pool/)</b>

$ node init.js or node ./init.js

<b>If you need to run as super user (eg. when you implement SSL)</b>

$ sudo /home/$USER/.nvm/node/versions/v12.22.12/bin/node init.js  -  [Check exaclty the full path for your nodejs version under .nvm to be sure]

If everything went smooth, now you should have Satoxcoin Node up and running as well as the pool and website.













