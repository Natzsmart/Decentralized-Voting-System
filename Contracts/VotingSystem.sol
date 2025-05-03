// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VoterControl {
    address public admin;

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }

    function changeAdmin(address _newAdmin) public onlyAdmin {
        admin = _newAdmin;
    }
}

contract ElectionInfo {
    string public electionName;

    constructor(string memory _name) {
        electionName = _name;
    }

    function getElectionName() public view returns (string memory) {
        return electionName;
    }
}

contract CandidateRegistry is ElectionInfo {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public hasVoted;
    uint public totalCandidates;

    constructor(string memory _electionName) ElectionInfo(_electionName) {}

    function addCandidate(string calldata _name) public virtual {}

    function vote(uint _candidateId) public virtual {}

    function getCandidate(uint _id) public view returns (string memory, uint) {
        require(_id < totalCandidates, "Invalid candidate ID");
        Candidate memory c = candidates[_id];
        return (c.name, c.voteCount);
    }

    function getTotalCandidates() public view returns (uint) {
        return totalCandidates;
    }
}

contract VotingSystem is CandidateRegistry, VoterControl {
    constructor(string memory _electionName)
        CandidateRegistry(_electionName)
        VoterControl() {}

    function addCandidate(string calldata _name) public override onlyAdmin {
        candidates[totalCandidates] = Candidate(totalCandidates, _name, 0);
        totalCandidates++;
    }

    function vote(uint _candidateId) public override {
        require(!hasVoted[msg.sender], "Already voted");
        require(_candidateId < totalCandidates, "Invalid candidate ID");

        hasVoted[msg.sender] = true;
        candidates[_candidateId].voteCount++;
    }

    function getElectionSummary(uint _id) public view returns (
        string memory name,
        uint voteCount,
        string memory election,
        address adminAddress
    ) {
        (string memory _name, uint _votes) = getCandidate(_id);
        return (_name, _votes, getElectionName(), admin);
    }
}
