// This library is helpful for string sorting.

// Generally, romanization is complex when we have to let it suit many
// languages, especially we have to meet many difficulties. Currently we
// have to consider:
/*
 * - The same letter in different languages may reads differently, so we have
 *   to consider which language to use for the same alphabet.
 * - Some languages can use only consonant letters to describe pronunciations,
 *   and we have to guess how it pronounces according to our knowledge of the
 *   language, either mannually or get help from AI.
 */
// Currently there is NO library to provide ways to romanize different
// languages using different alphabets, based on the pronunciations, not only
// Dart, but in all programming languages. We may have to develop a library
// that do the function later, but for now the need of i18n has to be delayed
// as we have to show the core function of the app.

// Now let's use a function to show how to use the library of romanization
// and now we can only convert Chinese to its Pinyin form.
// Note the parameters are not completed.
import 'package:lpinyin/lpinyin.dart';
String romanization(String source){
  return PinyinHelper.getPinyinE(
    source,
    separator: '',
    format: PinyinFormat.WITHOUT_TONE
  );
}