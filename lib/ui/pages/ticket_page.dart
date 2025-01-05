part of 'pages.dart';

class TicketPage extends StatefulWidget {
  final bool isExpiredTicket;

  TicketPage({this.isExpiredTicket = false});

  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  late bool isExpiredTickets;

  @override
  void initState() {
    super.initState();
    isExpiredTickets = widget.isExpiredTicket;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Content Section
          BlocBuilder<TicketBloc, TicketState>(
            builder: (_, ticketState) {
              var filteredTickets = ticketState.tickets.where((ticket) {
                return isExpiredTickets
                    ? ticket.time.isBefore(DateTime.now())
                    : !ticket.time.isBefore(DateTime.now());
              }).toList();

              return Container(
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: TicketViewer(filteredTickets),
              );
            },
          ),
          // Header Section
          Container(
            height: 113,
            color: accentColor1,
          ),
          SafeArea(
            child: ClipPath(
              child: Container(
                height: 113,
                color: accentColor1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 24, bottom: 32),
                      child: Text(
                        "My Tickets",
                        style: whiteTextFont.copyWith(fontSize: 20),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        _buildTab("Newest", !isExpiredTickets),
                        _buildTab("Oldest", isExpiredTickets),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, bool isActive) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpiredTickets = title == "Oldest";
        });
      },
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: whiteTextFont.copyWith(
              fontSize: 16,
              color: isActive ? Colors.white : Color(0xFF6F678E),
            ),
          ),
          SizedBox(height: 15),
          Container(
            height: 4,
            width: MediaQuery.of(context).size.width * 0.5,
            color: isActive ? accentColor2 : Colors.transparent,
          ),
        ],
      ),
    );
  }
}

class TicketViewer extends StatelessWidget {
  final List<Ticket> tickets;

  TicketViewer(this.tickets);

  @override
  Widget build(BuildContext context) {
    tickets.sort((a, b) => a.time.compareTo(b.time));

    return ListView.builder(
      itemCount: tickets.length,
      itemBuilder: (_, index) {
        var ticket = tickets[index];
        return GestureDetector(
          onTap: () {
            // Implement navigation to ticket details
          },
          child: Container(
            margin: EdgeInsets.only(top: index == 0 ? 133 : 20),
            child: Row(
              children: <Widget>[
                Container(
                  width: 70,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(imagesBaseUrl +
                          'w500' +
                          ticket.movieDetail.posterPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        ticket.movieDetail.title,
                        style: blackTextFont.copyWith(fontSize: 18),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6),
                      Text(
                        ticket.movieDetail.genresAndLanguage,
                        style: greyTextFont.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 6),
                      Text(
                        ticket.theater.name,
                        style: greyTextFont.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
