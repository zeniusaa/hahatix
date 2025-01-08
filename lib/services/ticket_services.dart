part of 'services.dart';

class TicketServices {
  static CollectionReference ticketCollection =
      FirebaseFirestore.instance.collection('tickets');

  static Future<void> saveTicket(String id, Ticket ticket) async {
    try {
      await ticketCollection.doc(ticket.bookingCode).set({
        'movieID': ticket.movieDetail.id,
        'userID': id,
        'theaterName': ticket.theater.name,
        'time': ticket.time.millisecondsSinceEpoch,
        'bookingCode': ticket.bookingCode,
        'seats': ticket.seatsInString,
        'name': ticket.name,
        'totalPrice': ticket.totalPrice
      });
    } catch (e) {
      print("Error saving ticket: $e");
    }
  }

  static Future<List<Ticket>> getTickets(String userId) async {
    try {
      QuerySnapshot snapshot = await ticketCollection.get();

      var documents = snapshot.docs.where((doc) => doc['userID'] == userId);

      List<Ticket> tickets = [];
      for (var document in documents) {
        MovieDetail movieDetail =
            await MovieServices.getDetails(null, movieID: document['movieID']);
        tickets.add(Ticket(
          movieDetail: movieDetail,
          theater: Theater(document['theaterName']),
          time: DateTime.fromMillisecondsSinceEpoch(document['time']),
          bookingCode: document['bookingCode'],
          seats: document['seats'].toString().split(','),
          name: document['name'],
          totalPrice: document['totalPrice'],
        ));
      }

      return tickets;
    } catch (e) {
      print("Error fetching tickets: $e");
      return [];
    }
  }
}
