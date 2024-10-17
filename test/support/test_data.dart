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
  content: 'begin, to begin is half the work let half still remain, again begin this and thou wilt have finished.',
  moodType: MoodType.awesome.text,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final testEntries = [
  JournalEntry(
    entryID: 1,
    content: 'begin, to begin is half the work let half still remain, again begin this and thou wilt have finished.',
    moodType: MoodType.awesome.text,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  JournalEntry(
    entryID: 2,
    content: 'compund intrst is the eighth wonder of the world',
    moodType: MoodType.awesome.text,
    createdAt: DateTime.now().add(const Duration(days: -3)),
    updatedAt: DateTime.now().add(const Duration(days: -3)),
  ),
  JournalEntry(
    entryID: 3,
    content: "the man who thinks he can and the man who thinks he can't are both right; which one are you?",
    moodType: MoodType.happy.text,
    createdAt: DateTime.now().add(const Duration(days: -5)),
    updatedAt: DateTime.now().add(const Duration(days: -5)),
  ),
  JournalEntry(
    entryID: 4,
    content: 'calmness is emptiness, emptiness is calmness.',
    moodType: MoodType.okay.text,
    createdAt: DateTime.now().add(const Duration(days: -7)),
    updatedAt: DateTime.now().add(const Duration(days: -7)),
  ),
];

final testLikedQuotes = [
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

final testQuotes = [
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
