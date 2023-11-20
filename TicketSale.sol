// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./TicketLib.sol";

contract TicketSale {
    using TicketLib for TicketLib.Ticket;

    uint256 ticketCounter = 0;
    mapping(uint256 => TicketLib.Ticket) public tickets;
    mapping(string => mapping(string => uint256[])) public availableTickets;

    event TicketCreated(uint256 indexed ticketId, string from, string to, uint256 price);
    event TicketPurchased(uint256 indexed ticketId, address buyer);

    function createTicket(string memory _from, string memory _to, uint256 _price) public {
        ticketCounter++;
        TicketLib.Ticket storage newTicket = tickets[ticketCounter];
        newTicket.createTicket(_from, _to, _price, ticketCounter);
        availableTickets[_from][_to].push(ticketCounter);
        emit TicketCreated(ticketCounter, _from, _to, _price);
    }

    function buyTicket(uint256 _ticketId) public payable {
        require(_ticketId > 0 && _ticketId <= ticketCounter, "Ticket does not exist");
        TicketLib.Ticket storage ticket = tickets[_ticketId];
        require(!ticket.isTicketOwned(), "Ticket is already sold");
        require(msg.value >= ticket.price, "Insufficient funds");

        ticket.transferTicket(msg.sender);
        emit TicketPurchased(_ticketId, msg.sender);
    }

    function searchTicket(uint256 _ticketId) public view returns (TicketLib.Ticket memory) {
        require(_ticketId > 0 && _ticketId <= ticketCounter, "Ticket does not exist");
        return tickets[_ticketId];
    }
}
