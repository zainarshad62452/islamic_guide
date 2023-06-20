import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RatingWidget extends StatefulWidget {
  String? uid;
  String? id;
  RatingWidget({this.uid,this.id});

  @override
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  double _rating = 0.0;

  Future<void> _saveRatingToFirestore() async {
    try {
      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(widget.uid)
          .update({'rating': _rating});
      await FirebaseFirestore.instance
          .collection('PendingAppointments')
          .doc(widget.id)
          .update({'isRated': true});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Rating saved successfully.'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving rating.'),
        ),
      );
    }
  }

  Widget _buildStar(int starIndex) {
    return IconButton(
      onPressed: () {
        setState(() {
          _rating = starIndex + 1;
        });
      },
      icon: Icon(
        starIndex < _rating ? Icons.star : Icons.star_border,
        color: Colors.indigo,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) => _buildStar(index)),
        ),
        MaterialButton(
          color: Colors.tealAccent.shade700,
          textColor: Colors.white,
          onPressed: _rating > 0 ? _saveRatingToFirestore : null,
          child: Text('Submit Rating'),
        ),
      ],
    );
  }
}
