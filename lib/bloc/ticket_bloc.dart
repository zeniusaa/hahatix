import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hahatix/models/models.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc() : super(TicketState([])) {
    on<TicketEvent>((event, emit) async {
      if (event is BuyTicket) {
        List<Ticket> updatedTickets = state.tickets;
        updatedTickets.add(event.ticket);
        emit(TicketState(updatedTickets));
      } else if (event is GetTickets) {
        emit(TicketState(state.tickets));
      }
    });
  }
}
