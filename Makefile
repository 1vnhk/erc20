-include .env

.PHONY: all test test-zk clean deploy fund help install snapshot format anvil install deploy deploy-sepolia verify

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

all: clean remove install update build

# Clean the repo
clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

install :; forge install cyfrin/foundry-devops && forge install foundry-rs/forge-std && forge install openzeppelin/openzeppelin-contracts

# Update Dependencies
update:; forge update

build:; forge build

test :; forge test 

snapshot :; forge snapshot

format :; forge fmt

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

deploy:
	@forge script script/DeployToken.s.sol:DeployToken --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

deploy-sepolia:
	@forge script script/DeployToken.s.sol:DeployToken --rpc-url $(SEPOLIA_RPC_URL) --account $(SEPOLIA_ACCOUNT) --sender $(SENDER) --etherscan-api-key $(ETHERSCAN_API_KEY) --broadcast --verify

verify:
	@forge verify-contract --chain-id 11155111 --num-of-optimizations 200 --watch --constructor-args 0x00000000000000000000000000000000000000000000d3c21bcecceda1000000 --etherscan-api-key $(ETHERSCAN_API_KEY) src/OurToken.sol:OurToken