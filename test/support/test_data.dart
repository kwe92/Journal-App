import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/features/quotes/shared/models/liked_quote.dart';
import 'package:journal_app/features/shared/factory/factory.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';

final testCurrentUser = AbstractFactory.createUser(
  userType: UserType.curentUser,
  firstName: 'Baki',
  lastName: 'Hanma',
  email: 'baki@grappler.io',
  phoneNumber: '+11234567890',
);

final testTempUser = AbstractFactory.createUser(
  userType: UserType.curentUser,
  firstName: 'Baki',
  lastName: 'Hanma',
  email: 'baki@grappler.io',
  phoneNumber: '+11234567890',
);

final testEntry = JournalEntry(
  entryID: 1,
  content: 'calmness in activity',
  moodType: MoodType.okay.text,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final List<JournalEntry> testEntries = [
  JournalEntry(
    entryID: 1,
    content: 'calmness in activity',
    moodType: MoodType.okay.text,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  JournalEntry(
    entryID: 2,
    content: 'in the beginners mind there are many possibilities, in the experts mind there are few.',
    moodType: MoodType.okay.text,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  JournalEntry(
    entryID: 3,
    content: 'Moment by moment, we forget ourselves, being a good bondfire we burn all worry, fear, doubt and anxiety',
    moodType: MoodType.okay.text,
    createdAt: DateTime.now().add(const Duration(days: -3)),
    updatedAt: DateTime.now().add(const Duration(days: -3)),
  ),
  JournalEntry(
    entryID: 4,
    content: 'begin, to begin is half the work, let half still remain, again begin this and though wilt have finished',
    moodType: MoodType.okay.text,
    createdAt: DateTime.now().add(const Duration(days: -5)),
    updatedAt: DateTime.now().add(const Duration(days: -5)),
  ),
  JournalEntry(
    entryID: 5,
    content:
        'by your thoughts you shall be justified and by your thoughts you shall condemn yourself, build your own prision within your mind',
    moodType: MoodType.okay.text,
    createdAt: DateTime.now().add(const Duration(days: -7)),
    updatedAt: DateTime.now().add(const Duration(days: -7)),
  ),
];

final List<LikedQuote> testLikedQuotes = [
  LikedQuote(
    id: 1101,
    author: 'a',
    quote: 'a',
    isLiked: true,
    createdAt: DateTime.now(),
  ),
  LikedQuote(
    id: 1102,
    author: 'b',
    quote: 'b',
    isLiked: true,
    createdAt: DateTime.now(),
  ),
  LikedQuote(
    id: 1103,
    author: 'c',
    quote: 'c',
    isLiked: true,
    createdAt: DateTime.now(),
  ),
];

final List<LikedQuote> testQuotes = [
  LikedQuote(
    id: 1104,
    author: 'd',
    quote: 'd',
    isLiked: false,
    createdAt: DateTime.now(),
  ),
  LikedQuote(
    id: 1105,
    author: 'e',
    quote: 'e',
    isLiked: false,
    createdAt: DateTime.now(),
  ),
  LikedQuote(
    id: 1106,
    author: 'f',
    quote: 'f ',
    isLiked: false,
    createdAt: DateTime.now(),
  ),
];
