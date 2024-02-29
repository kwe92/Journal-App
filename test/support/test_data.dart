import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/features/quotes/shared/models/liked_quote_imp.dart';
import 'package:journal_app/features/quotes/shared/models/quote.dart';
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
  entryId: 1,
  uid: 1,
  content: 'calmness in activity',
  moodType: MoodType.okay.text,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final List<JournalEntry> testEntries = [
  JournalEntry(
    entryId: 1,
    uid: 1,
    content: 'calmness in activity',
    moodType: MoodType.okay.text,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  JournalEntry(
    entryId: 2,
    uid: 2,
    content: 'in the beginners mind there are many possibilities, in the experts mind there are few.',
    moodType: MoodType.okay.text,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  JournalEntry(
    entryId: 3,
    uid: 3,
    content: 'Moment by moment, we forget ourselves, being a good bondfire we burn all worry, fear, doubt and anxiety',
    moodType: MoodType.okay.text,
    createdAt: DateTime.now().add(const Duration(days: -3)),
    updatedAt: DateTime.now().add(const Duration(days: -3)),
  ),
  JournalEntry(
    entryId: 4,
    uid: 4,
    content: 'begin, to begin is half the work, let half still remain, again begin this and though wilt have finished',
    moodType: MoodType.okay.text,
    createdAt: DateTime.now().add(const Duration(days: -5)),
    updatedAt: DateTime.now().add(const Duration(days: -5)),
  ),
  JournalEntry(
    entryId: 5,
    uid: 5,
    content:
        'by your thoughts you shall be justified and by your thoughts you shall condemn yourself, build your own prision within your mind',
    moodType: MoodType.okay.text,
    createdAt: DateTime.now().add(const Duration(days: -7)),
    updatedAt: DateTime.now().add(const Duration(days: -7)),
  ),
];

final List<Quote> testLikedQuotes = [
  LikedQuoteImp(
    id: 1101,
    userId: 1101,
    author: 'a',
    quote: 'a',
    isLiked: true,
  ),
  LikedQuoteImp(
    id: 1102,
    userId: 1102,
    author: 'b',
    quote: 'b',
    isLiked: true,
  ),
  LikedQuoteImp(
    id: 1103,
    userId: 1103,
    author: 'c',
    quote: 'c',
    isLiked: true,
  ),
];

final List<Quote> testQuotes = [
  LikedQuoteImp(
    id: 1104,
    userId: 1104,
    author: 'd',
    quote: 'd',
    isLiked: false,
  ),
  LikedQuoteImp(
    id: 1105,
    userId: 1105,
    author: 'e',
    quote: 'e',
    isLiked: false,
  ),
  LikedQuoteImp(
    id: 1106,
    userId: 1106,
    author: 'f',
    quote: 'f ',
    isLiked: false,
  ),
];
