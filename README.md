# action_unit_architecture

## Basic concept

MVVM + Middleware for Event Handler

## Model (or its dependencies)

Something like `ItemRepository` or `ShopApiClient` is pure Dart code.
Dependencies are injected by constructor and static `Provider` of riverpod
provides default construction.

```dart
class ItemRepository {
    final ItemDao itemDao;

    const ItemRepository({required this.itemDao});

    static final provider = Provider((ref) => ItemRepository(
        itemDao: ref.read(ItemDao.provider),
    ));

    Future<Item> find(int id) async { ... }
}
```

## ViewModel

ViewModel is a set of providers.
This layer is fully using riverpod features.

## View

Flutter widgets using providers of ViewModel.
However, depending on its simplicity, it is reasonable to use Model or Unit layer directly.

## Unit

`Unit` is a re-usable part of View and ViewModel.

The feature of app and widget are inseparable.
These are dependent mutually.
Thus, extracting a set of the business logic and some widgets is reasonable.

## Middleware for Event Handler

`SafeActionDispatcher` is `ActionDispatcher` with error handler.
In that process, outputs logs or displays general-purpose dialogs
for unexpected errors.
