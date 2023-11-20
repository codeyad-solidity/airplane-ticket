// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library TicketLib {
    struct Ticket {
        string from;
        string to;
        address owner;
        uint256 price;
        uint256 id;
    }

    function createTicket(Ticket storage _ticket, string memory _from, string memory _to, uint256 _price, uint256 _id)
        internal
    {
        _ticket.from = _from;
        _ticket.to = _to;
        _ticket.owner = address(0);
        _ticket.price = _price;
        _ticket.id = _id;
    }

    function isTicketOwned(Ticket storage _ticket) internal view returns (bool) {
        return _ticket.owner != address(0);
    }

    function transferTicket(Ticket storage _ticket, address _newOwner) internal {
        _ticket.owner = _newOwner;
    }
}
