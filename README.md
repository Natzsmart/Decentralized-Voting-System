# 🗳️ Decentralized Voting System (Solidity)

This project is a modular, decentralized voting system built using Solidity. It allows administrators to register candidates and users to vote securely while enforcing one vote per address. The structure follows a clear inheritance pattern inspired by the `FullSchoolSystem` contract setup.

---

## 📁 Project Structure

VotingSystemProject/
├── Contract/
│ └── VotingSystem.sol # Main Solidity contract
├── README.md # Project documentation (this file)


---

## 🚀 Features

- ✅ Candidate registration by admin
- ✅ Voting restricted to one vote per user
- ✅ Election name tracking
- ✅ Admin ownership and transfer of control
- ✅ Modular contract design using inheritance
- ✅ Functions to get candidate and election details

---

## 🏗️ Architecture Overview

### 1. **VoterControl**
- Handles admin ownership and access restriction
- Functions:
  - `onlyAdmin` modifier
  - `changeAdmin(address)`

### 2. **ElectionInfo**
- Stores election metadata
- Functions:
  - `getElectionName()`

### 3. **CandidateRegistry**
- Core voting logic
- Struct:
  ```solidity
  struct Candidate {
      uint id;
      string name;
      uint voteCount;
  }

* Mappings:
- `mapping(uint => Candidate) candidates`
- `mapping(address => bool) hasVoted`

* Functions:
- `addCandidate(string calldata name) (virtual)`

- `vote(uint candidateId) (virtual)`

- `getCandidate(uint id)`

- `getTotalCandidates()`

---
### VotingSystem
- Inherits from all contracts

- Implements actual `addCandidate and `vote` logic

- Adds `getElectionSummary()` for combined view
---

### 🔧 How to Deploy and Test on Remix
1. Setup
- Visit Remix IDE

- Upload the full project folder

- Open `VotingSystem.sol`

2. Compile
Select compiler version 0.8.20

Click Compile `VotingSystem.sol`

3. Deploy
Go to the Deploy & Run Transactions tab

Choose Remix VM (Cancun)

Select `VotingSystem` contract

Pass a string argument (e.g., "Presidential Election 2025")

Click Deploy

---

### 🧪 How to Interact

➕ Add Candidate (Admin Only)
```solidity
addCandidate("Alice")

---
### 🗳️ Vote (New Account Required)
Switch to a different Remix account

Call:
```solidity
vote(0) // Votes for candidate with ID 0

---

🔍 Check Candidate
```solidity
getCandidate(0) // Returns ("Alice", 1)

---
### 🔐 Check Double Voting
Try calling vote(0) again from the same address — should fail

---
### 📊 Get Election Summary
```solidity
getElectionSummary(0)
// Returns: name, voteCount, electionName, adminAddress
---