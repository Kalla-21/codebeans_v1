// ============================================
// FILE: lib/data/user_data.dart
// ============================================

class TestUser {
  final String uid; // Added UID (Manual ID for testing)
  final String email;
  final String password;
  final String username;
  final String bio;
  final String photoUrl; // Added for profile picture
  final Map<String, bool> progress; // Added to track completed lessons (lessonId: true)

  const TestUser({
    required this.uid,
    required this.email,
    required this.password,
    required this.username,
    required this.bio,
    required this.photoUrl,
    required this.progress,
  });
}

const List<TestUser> initialTestUsers = [
  TestUser(
    uid: 'user_ichigo_001',
    email: 'ichigobankai@example.com',
    password: 'GetsugaTensho!',
    username: 'Ichigo Kurosaki',
    bio: 'The substitute Shinigami and main protagonist of Bleach.',
    photoUrl: 'https://i.pinimg.com/1200x/07/6e/da/076edadb2a483e1c2605898b6ed8ea13.jpg',
    progress: {'java_001': true, 'java_002': true}, // Example progress
  ),
  TestUser(
    uid: 'user_rukia_002',
    email: 'rukiaice@example.com',
    password: 'SodeNoShirayuki!',
    username: 'Rukia Kuchiki',
    bio: 'A Shinigami of the 13th Division in Bleach.',
    photoUrl: 'https://i.pinimg.com/1200x/ab/83/e7/ab83e759fbf0e1e216aeb6dd46241fc8.jpg',
    progress: {'java_001': true},
  ),
  TestUser(
    uid: 'user_gon_003',
    email: 'gonnen@example.com',
    password: 'JajankenRock!',
    username: 'Gon Freecss',
    bio: 'A Rookie Hunter and protagonist of Hunter x Hunter.',
    photoUrl: 'https://i.pinimg.com/736x/71/7c/2d/717c2dc3b9d7557e2f9253fc766f499d.jpg',
    progress: {},
  ),
  TestUser(
    uid: 'user_killua_004',
    email: 'killuagodspeed@example.com',
    password: 'LightningPalm!',
    username: 'Killua Zoldyck',
    bio: 'The best friend of Gon and heir to the Zoldyck Family of assassins in Hunter x Hunter.',
    photoUrl: 'https://i.pinimg.com/736x/8c/e6/00/8ce60069d29571f06fa05eeed4ff3714.jpg',
    progress: {'java_001': true, 'java_002': true, 'java_003': true},
  ),
  TestUser(
    uid: 'user_frieren_005',
    email: 'frierenelf@example.com',
    password: 'GrimoireCollector!',
    username: 'Frieren',
    bio: 'An elven mage who was part of the hero\'s party that defeated the Demon King in Frieren: Beyond Journey\'s End.',
    photoUrl: 'https://i.pinimg.com/736x/4b/2a/38/4b2a382e1ecd102c55619e06775d04a9.jpg',
    progress: {'java_001': true, 'java_002': true, 'java_003': true, 'java_004': true},
  ),
  TestUser(
    uid: 'user_fern_006',
    email: 'fernmagic@example.com',
    password: 'ZoltraakBeam!',
    username: 'Fern',
    bio: 'Frieren\'s young human apprentice mage in Frieren: Beyond Journey\'s End.',
    photoUrl: 'assets/avatars/fern.png',
    progress: {'java_001': true},
  ),
  TestUser(
    uid: 'user_yuji_007',
    email: 'yujicursed@example.com',
    password: 'DivergentFist!',
    username: 'Yuji Itadori',
    bio: 'A Jujutsu Sorcerer and the vessel for Sukuna in Jujutsu Kaisen.',
    photoUrl: 'https://i.pinimg.com/736x/cc/fd/29/ccfd29bd60d3530133bcdf6c29b274dd.jpg',
    progress: {},
  ),
  TestUser(
    uid: 'user_megumi_008',
    email: 'megumishikigami@example.com',
    password: 'DivineDog!',
    username: 'Megumi Fushiguro',
    bio: 'A Grade 2 Jujutsu Sorcerer from the Tokyo Metropolitan Curse Technical College in Jujutsu Kaisen.',
    photoUrl: 'https://i.pinimg.com/736x/95/41/86/9541864c1d0dacc0786617b953df44fb.jpg',
    progress: {'java_001': true, 'java_002': true},
  ),
  TestUser(
    uid: 'user_nobara_009',
    email: 'nobaranails@example.com',
    password: 'StrawDoll!',
    username: 'Nobara Kugisaki',
    bio: 'A Grade 3 Jujutsu Sorcerer from the Tokyo Metropolitan Curse Technical College in Jujutsu Kaisen.',
    photoUrl: 'https://i.pinimg.com/736x/ef/75/5e/ef755e00958dbf2f1f16307bd794936e.jpg',
    progress: {'java_001': true},
  ),
  TestUser(
    uid: 'user_gojo_010',
    email: 'gojoinfinity@example.com',
    password: 'InfiniteVoid!',
    username: 'Satoru Gojo',
    bio: 'A Special Grade Jujutsu Sorcerer, known as the strongest in Jujutsu Kaisen.',
    photoUrl: 'https://i.pinimg.com/736x/3b/89/55/3b8955693006933f1a8b4f9eb26ba2f8.jpg',
    progress: {
      'java_001': true, 'java_002': true, 'java_003': true, 'java_004': true,
      'java_005': true, 'java_006': true, 'java_007': true, 'java_008': true,
      'java_009': true, 'java_010': true
    }, // Gojo has finished everything because he is the strongest
  ),
  TestUser(
    uid: 'user_admin_999',
    email: 'admin1@example.com',
    password: 'admin1',
    username: 'Ransu Herrera',
    bio: 'I LOVE KARINA FROM AESPA!',
    photoUrl: 'https://i.pinimg.com/1200x/b4/80/6f/b4806f5b637c1416db1716af74469e1f.jpg',
    progress: {},
  ),
  TestUser(
    uid: 'renzo',
    email: 'a@mail.com',
    password: 'a',
    username: 'Renzo',
    bio: 'at the end of the day is night, goodnight',
    photoUrl: 'https://i.pinimg.com/1200x/b4/80/6f/b4806f5b637c1416db1716af74469e1f.jpg',
    progress: {},
  ),
];