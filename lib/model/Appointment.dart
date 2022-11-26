class Appointment {
  final String place_type;
  final DateTime time;
  final String service;
  final String id;

  Appointment({
  required this.place_type, 
  required this.time, 
  required this.service, 
  required this.id
  });
}

final List<String> place_type = [
    'Condo 1 BR (40 sq.m.)',
    'Condo 1 BR (50 sq.m.)',
    'Condo 2 BR (80 sq.m.)',
    'Condo 3 BR (100 sq.m.)',
    'House 1 Story (100 sq.m.)',
    'House 2-3 Stories (100-200 sq.m.)',
    'House (> 200 sq.m.)',
    'Office/ Workplace'
  ];