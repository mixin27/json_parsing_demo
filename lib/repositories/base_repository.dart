abstract class BaseRepository<T> {
  Future<List<T>> getAll();
  Future<T> findById<E>(E id);
}
