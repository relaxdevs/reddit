

import './settings.dart';


/*
openhermes2.5-mistral prompt

"""use same dart object - add translation ('ru', 'ar', 'de', 'es', 'fr', 'el', 'it', 'ja', 'ko', 'nl', 'pl', 'pt', 'tr', 'vi', 'zh', 'zh_TW').
example: 'Karma': {'en':'Karma','de':'...','ch':'...'} 
{
  'Karma': {},
  'Feed': {},
  'Comments': {},
  'Suspended': {},
  'Latest': {},
  'del.cmnt': {'en': 'Deleted comment'},
  'no.cmnt': {'en': 'No comments'},
  'err': {'en': 'Unknown error'},
}
"""
*/

Map<String, Map<String, String>> obj = <String, Map<String, String>>{
  'Karma': {
    'en': 'Karma',
    'ru': 'Карма',
    'ar': 'الْحَمَد',
    'de': 'Karma',
    'es': 'Karma',
    'fr': 'Karma',
    'el': 'Κάρμα',
    'it': 'Karma',
    'ja': 'カーマ',
    'ko': '카르마',
    'nl': 'Karma',
    'pl': 'Karma',
    'pt': 'Karma',
    'tr': 'Karma',
    'vi': 'Karma',
    'zh': '嘉美',
    'zh_TW': '嘉美'
  },
  'Feed': {
    'en': 'Feed',
    'ru': 'Лента',
    'ar': 'المصدر',
    'de': 'Feed',
    'es': 'flujo de contenido',
    'fr': 'abonnement',
    'el': 'ρυθμίσμαta',
    'it': 'flusso di contenuti',
    'ja': 'フィード',
    'ko': '피드',
    'nl': 'feed',
    'pl': 'strumień treści',
    'pt': 'fluxo de conteúdo',
    'tr': 'akıllar',
    'vi': 'các mục',
    'zh': '订阅',
    'zh_TW': '訂閱'
  },
  'Comments': {
    'en': 'Comments',
    'ru': 'Комментарии',
    'ar': 'التعليقات',
    'de': 'Kommentare',
    'es': 'Comentarios',
    'fr': 'Commentaires',
    'el': 'σχολίες',
    'it': 'Commenti',
    'ja': 'コメント',
    'ko': '댓글',
    'nl': 'Reacties',
    'pl': 'Komentarze',
    'pt': 'Comentários',
    'tr': 'Yorumlar',
    'vi': 'Bình luận',
    'zh': '评论',
    'zh_TW': '評論'
  },
  'Suspended': {
    'en': 'Suspended',
    'ru': 'Заблокирован',
    'ar': 'معلق',
    'de': 'Ausgesetzt',
    'es': 'Sospendido',
    'fr': 'suspendu',
    'el': 'Προστεθεί πάνω στην συζήτηση',
    'it': 'Sospeso',
    'ja': '停止中',
    'ko': '쇼핑중지',
    'nl': 'Onderbroken',
    'pl': 'Wstrzymany',
    'pt': 'Suspendido',
    'tr': 'Durdurulan',
    'vi': 'Ngừng hoạt động',
    'zh': '暂停',
    'zh_TW': '暫時停用'
  },
  'Latest': {
    'en': 'Latest',
    'ru': 'Последние',
    'ar': 'أخرى',
    'de': 'Neueste',
    'es': 'Últimos',
    'fr': 'Derniers',
    'el': 'Τριανταφύλλου χάρτης',
    'it': 'Più recenti',
    'ja': '最新の',
    'ko': '최근의',
    'nl': 'Nieuwste',
    'pl': 'Ostatnie',
    'pt': 'Mais recentes',
    'tr': 'Sonlar',
    'vi': 'Mới nhất',
    'zh': '最新的',
    'zh_TW': '最新的'
  },
  'del.cmnt': {
    'en': 'Deleted comment',
    'ru': 'Удаленный комментарий',
    'ar': 'تم حذف التعليق',
    'de': 'Löscher Kommentar',
    'es': 'Comentario eliminado',
    'fr': 'Commentaire supprimé',
    'el': 'Αφαιρεμένο σχόλιο',
    'it': 'Commento eliminato',
    'ja': 'コメントを削除しました',
    'ko': '삭제된 댓글',
    'nl': 'Verwijderde opmerking',
    'pl': 'Usunięty komentarz',
    'pt': 'Comentário apagado',
    'tr': 'Silinen yorum',
    'vi': 'Bình luận đã xóa',
    'zh': '已删除评论',
    'zh_TW': '已刪除評論'
  },
  'no.cmnt': {
    'en': 'No comments',
    'ru': 'Комментариев нет',
    'ar': 'لا توجد تعليقات',
    'de': 'Keine Kommentare',
    'es': 'Sin comentarios',
    'fr': 'Aucun commentaire',
    'el': 'Σχόλια δεν υπάρχουν',
    'it': 'Nessun commento',
    'ja': 'コメントはありません',
    'ko': '댓글이 없습니다.',
    'nl': 'Geen reacties',
    'pl': 'Brak komentarzy',
    'pt': 'Nenhuma resposta',
    'tr': 'Yorum yok',
    'vi': 'Không có bình luận',
    'zh': '无评论',
    'zh_TW': '無評論'
  },
  'err': {
    'en': 'Unknown error',
    'ru': 'Неизвестная ошибка',
    'ar': 'خطأ ما غير معروف',
    'de': 'Unbekannter Fehler',
    'es': 'Error desconocido',
    'fr': 'Erreur inconnue',
    'el': 'Ανεπικαιροτέρως σφάλμα',
    'it': 'Errore sconosciuto',
    'ja': '不明なエラー',
    'ko': '알 수 없는 오류',
    'nl': 'Onbekende fout',
    'pl': 'Nieznany błąd',
    'pt': 'Erro desconhecido',
    'tr': 'Bilinmeyen bir hata',
    'vi': 'Lỗi không xác định',
    'zh': '未知错误',
    'zh_TW': '未知錯誤'
  }
};

String localization(String id) => obj[id]?[settings.locale] ?? id;