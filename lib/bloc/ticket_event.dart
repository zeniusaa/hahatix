part of 'ticket_bloc.dart';

sealed class TicketEvent extends Equatable {
  const TicketEvent();
}

class BuyTicket extends TicketEvent {
  final Ticket ticket;
  final String userId;

  BuyTicket(this.ticket, this.userId);

  @override
  List<Object> get props => [ticket, userId];
}

class GetTickets extends TicketEvent {
  final String userId;

  GetTickets(this.userId);

  @override
  List<Object> get props => [];
}
