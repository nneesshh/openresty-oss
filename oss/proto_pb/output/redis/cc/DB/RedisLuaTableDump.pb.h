// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: RedisLuaTableDump.proto

#ifndef PROTOBUF_INCLUDED_RedisLuaTableDump_2eproto
#define PROTOBUF_INCLUDED_RedisLuaTableDump_2eproto

#include <string>

#include <google/protobuf/stubs/common.h>

#if GOOGLE_PROTOBUF_VERSION < 3006001
#error This file was generated by a newer version of protoc which is
#error incompatible with your Protocol Buffer headers.  Please update
#error your headers.
#endif
#if 3006001 < GOOGLE_PROTOBUF_MIN_PROTOC_VERSION
#error This file was generated by an older version of protoc which is
#error incompatible with your Protocol Buffer headers.  Please
#error regenerate this file with a newer version of protoc.
#endif

#include <google/protobuf/io/coded_stream.h>
#include <google/protobuf/arena.h>
#include <google/protobuf/arenastring.h>
#include <google/protobuf/generated_message_table_driven.h>
#include <google/protobuf/generated_message_util.h>
#include <google/protobuf/inlined_string_field.h>
#include <google/protobuf/metadata.h>
#include <google/protobuf/message.h>
#include <google/protobuf/repeated_field.h>  // IWYU pragma: export
#include <google/protobuf/extension_set.h>  // IWYU pragma: export
#include <google/protobuf/unknown_field_set.h>
// @@protoc_insertion_point(includes)
#define PROTOBUF_INTERNAL_EXPORT_protobuf_RedisLuaTableDump_2eproto 

namespace protobuf_RedisLuaTableDump_2eproto {
// Internal implementation detail -- do not use these members.
struct TableStruct {
  static const ::google::protobuf::internal::ParseTableField entries[];
  static const ::google::protobuf::internal::AuxillaryParseTableField aux[];
  static const ::google::protobuf::internal::ParseTable schema[1];
  static const ::google::protobuf::internal::FieldMetadata field_metadata[];
  static const ::google::protobuf::internal::SerializationTable serialization_table[];
  static const ::google::protobuf::uint32 offsets[];
};
void AddDescriptors();
}  // namespace protobuf_RedisLuaTableDump_2eproto
namespace db {
class RedisListLuaTableDump;
class RedisListLuaTableDumpDefaultTypeInternal;
extern RedisListLuaTableDumpDefaultTypeInternal _RedisListLuaTableDump_default_instance_;
}  // namespace db
namespace google {
namespace protobuf {
template<> ::db::RedisListLuaTableDump* Arena::CreateMaybeMessage<::db::RedisListLuaTableDump>(Arena*);
}  // namespace protobuf
}  // namespace google
namespace db {

// ===================================================================

class RedisListLuaTableDump : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:db.RedisListLuaTableDump) */ {
 public:
  RedisListLuaTableDump();
  virtual ~RedisListLuaTableDump();

  RedisListLuaTableDump(const RedisListLuaTableDump& from);

  inline RedisListLuaTableDump& operator=(const RedisListLuaTableDump& from) {
    CopyFrom(from);
    return *this;
  }
  #if LANG_CXX11
  RedisListLuaTableDump(RedisListLuaTableDump&& from) noexcept
    : RedisListLuaTableDump() {
    *this = ::std::move(from);
  }

  inline RedisListLuaTableDump& operator=(RedisListLuaTableDump&& from) noexcept {
    if (GetArenaNoVirtual() == from.GetArenaNoVirtual()) {
      if (this != &from) InternalSwap(&from);
    } else {
      CopyFrom(from);
    }
    return *this;
  }
  #endif
  inline const ::google::protobuf::UnknownFieldSet& unknown_fields() const {
    return _internal_metadata_.unknown_fields();
  }
  inline ::google::protobuf::UnknownFieldSet* mutable_unknown_fields() {
    return _internal_metadata_.mutable_unknown_fields();
  }

  inline ::google::protobuf::Arena* GetArena() const final {
    return GetArenaNoVirtual();
  }
  inline void* GetMaybeArenaPointer() const final {
    return MaybeArenaPtr();
  }
  static const ::google::protobuf::Descriptor* descriptor();
  static const RedisListLuaTableDump& default_instance();

  static void InitAsDefaultInstance();  // FOR INTERNAL USE ONLY
  static inline const RedisListLuaTableDump* internal_default_instance() {
    return reinterpret_cast<const RedisListLuaTableDump*>(
               &_RedisListLuaTableDump_default_instance_);
  }
  static constexpr int kIndexInFileMessages =
    0;

  void UnsafeArenaSwap(RedisListLuaTableDump* other);
  void Swap(RedisListLuaTableDump* other);
  friend void swap(RedisListLuaTableDump& a, RedisListLuaTableDump& b) {
    a.Swap(&b);
  }

  // implements Message ----------------------------------------------

  inline RedisListLuaTableDump* New() const final {
    return CreateMaybeMessage<RedisListLuaTableDump>(NULL);
  }

  RedisListLuaTableDump* New(::google::protobuf::Arena* arena) const final {
    return CreateMaybeMessage<RedisListLuaTableDump>(arena);
  }
  void CopyFrom(const ::google::protobuf::Message& from) final;
  void MergeFrom(const ::google::protobuf::Message& from) final;
  void CopyFrom(const RedisListLuaTableDump& from);
  void MergeFrom(const RedisListLuaTableDump& from);
  void Clear() final;
  bool IsInitialized() const final;

  size_t ByteSizeLong() const final;
  bool MergePartialFromCodedStream(
      ::google::protobuf::io::CodedInputStream* input) final;
  void SerializeWithCachedSizes(
      ::google::protobuf::io::CodedOutputStream* output) const final;
  ::google::protobuf::uint8* InternalSerializeWithCachedSizesToArray(
      bool deterministic, ::google::protobuf::uint8* target) const final;
  int GetCachedSize() const final { return _cached_size_.Get(); }

  private:
  void SharedCtor();
  void SharedDtor();
  void SetCachedSize(int size) const final;
  void InternalSwap(RedisListLuaTableDump* other);
  protected:
  explicit RedisListLuaTableDump(::google::protobuf::Arena* arena);
  private:
  static void ArenaDtor(void* object);
  inline void RegisterArenaDtor(::google::protobuf::Arena* arena);
  private:
  inline ::google::protobuf::Arena* GetArenaNoVirtual() const {
    return _internal_metadata_.arena();
  }
  inline void* MaybeArenaPtr() const {
    return _internal_metadata_.raw_arena_ptr();
  }
  public:

  ::google::protobuf::Metadata GetMetadata() const final;

  // nested types ----------------------------------------------------

  // accessors -------------------------------------------------------

  // required bytes module = 1;
  bool has_module() const;
  void clear_module();
  static const int kModuleFieldNumber = 1;
  const ::std::string& module() const;
  void set_module(const ::std::string& value);
  #if LANG_CXX11
  void set_module(::std::string&& value);
  #endif
  void set_module(const char* value);
  void set_module(const void* value, size_t size);
  ::std::string* mutable_module();
  ::std::string* release_module();
  void set_allocated_module(::std::string* module);
  PROTOBUF_RUNTIME_DEPRECATED("The unsafe_arena_ accessors for"
  "    string fields are deprecated and will be removed in a"
  "    future release.")
  ::std::string* unsafe_arena_release_module();
  PROTOBUF_RUNTIME_DEPRECATED("The unsafe_arena_ accessors for"
  "    string fields are deprecated and will be removed in a"
  "    future release.")
  void unsafe_arena_set_allocated_module(
      ::std::string* module);

  // required bytes id = 2;
  bool has_id() const;
  void clear_id();
  static const int kIdFieldNumber = 2;
  const ::std::string& id() const;
  void set_id(const ::std::string& value);
  #if LANG_CXX11
  void set_id(::std::string&& value);
  #endif
  void set_id(const char* value);
  void set_id(const void* value, size_t size);
  ::std::string* mutable_id();
  ::std::string* release_id();
  void set_allocated_id(::std::string* id);
  PROTOBUF_RUNTIME_DEPRECATED("The unsafe_arena_ accessors for"
  "    string fields are deprecated and will be removed in a"
  "    future release.")
  ::std::string* unsafe_arena_release_id();
  PROTOBUF_RUNTIME_DEPRECATED("The unsafe_arena_ accessors for"
  "    string fields are deprecated and will be removed in a"
  "    future release.")
  void unsafe_arena_set_allocated_id(
      ::std::string* id);

  // required bytes l_val = 3;
  bool has_l_val() const;
  void clear_l_val();
  static const int kLValFieldNumber = 3;
  const ::std::string& l_val() const;
  void set_l_val(const ::std::string& value);
  #if LANG_CXX11
  void set_l_val(::std::string&& value);
  #endif
  void set_l_val(const char* value);
  void set_l_val(const void* value, size_t size);
  ::std::string* mutable_l_val();
  ::std::string* release_l_val();
  void set_allocated_l_val(::std::string* l_val);
  PROTOBUF_RUNTIME_DEPRECATED("The unsafe_arena_ accessors for"
  "    string fields are deprecated and will be removed in a"
  "    future release.")
  ::std::string* unsafe_arena_release_l_val();
  PROTOBUF_RUNTIME_DEPRECATED("The unsafe_arena_ accessors for"
  "    string fields are deprecated and will be removed in a"
  "    future release.")
  void unsafe_arena_set_allocated_l_val(
      ::std::string* l_val);

  // required bytes c_key = 4;
  bool has_c_key() const;
  void clear_c_key();
  static const int kCKeyFieldNumber = 4;
  const ::std::string& c_key() const;
  void set_c_key(const ::std::string& value);
  #if LANG_CXX11
  void set_c_key(::std::string&& value);
  #endif
  void set_c_key(const char* value);
  void set_c_key(const void* value, size_t size);
  ::std::string* mutable_c_key();
  ::std::string* release_c_key();
  void set_allocated_c_key(::std::string* c_key);
  PROTOBUF_RUNTIME_DEPRECATED("The unsafe_arena_ accessors for"
  "    string fields are deprecated and will be removed in a"
  "    future release.")
  ::std::string* unsafe_arena_release_c_key();
  PROTOBUF_RUNTIME_DEPRECATED("The unsafe_arena_ accessors for"
  "    string fields are deprecated and will be removed in a"
  "    future release.")
  void unsafe_arena_set_allocated_c_key(
      ::std::string* c_key);

  // required bytes c_val = 5;
  bool has_c_val() const;
  void clear_c_val();
  static const int kCValFieldNumber = 5;
  const ::std::string& c_val() const;
  void set_c_val(const ::std::string& value);
  #if LANG_CXX11
  void set_c_val(::std::string&& value);
  #endif
  void set_c_val(const char* value);
  void set_c_val(const void* value, size_t size);
  ::std::string* mutable_c_val();
  ::std::string* release_c_val();
  void set_allocated_c_val(::std::string* c_val);
  PROTOBUF_RUNTIME_DEPRECATED("The unsafe_arena_ accessors for"
  "    string fields are deprecated and will be removed in a"
  "    future release.")
  ::std::string* unsafe_arena_release_c_val();
  PROTOBUF_RUNTIME_DEPRECATED("The unsafe_arena_ accessors for"
  "    string fields are deprecated and will be removed in a"
  "    future release.")
  void unsafe_arena_set_allocated_c_val(
      ::std::string* c_val);

  // required bytes mainid = 6;
  bool has_mainid() const;
  void clear_mainid();
  static const int kMainidFieldNumber = 6;
  const ::std::string& mainid() const;
  void set_mainid(const ::std::string& value);
  #if LANG_CXX11
  void set_mainid(::std::string&& value);
  #endif
  void set_mainid(const char* value);
  void set_mainid(const void* value, size_t size);
  ::std::string* mutable_mainid();
  ::std::string* release_mainid();
  void set_allocated_mainid(::std::string* mainid);
  PROTOBUF_RUNTIME_DEPRECATED("The unsafe_arena_ accessors for"
  "    string fields are deprecated and will be removed in a"
  "    future release.")
  ::std::string* unsafe_arena_release_mainid();
  PROTOBUF_RUNTIME_DEPRECATED("The unsafe_arena_ accessors for"
  "    string fields are deprecated and will be removed in a"
  "    future release.")
  void unsafe_arena_set_allocated_mainid(
      ::std::string* mainid);

  // optional sfixed64 optime = 11;
  bool has_optime() const;
  void clear_optime();
  static const int kOptimeFieldNumber = 11;
  ::google::protobuf::int64 optime() const;
  void set_optime(::google::protobuf::int64 value);

  // @@protoc_insertion_point(class_scope:db.RedisListLuaTableDump)
 private:
  void set_has_module();
  void clear_has_module();
  void set_has_id();
  void clear_has_id();
  void set_has_l_val();
  void clear_has_l_val();
  void set_has_c_key();
  void clear_has_c_key();
  void set_has_c_val();
  void clear_has_c_val();
  void set_has_mainid();
  void clear_has_mainid();
  void set_has_optime();
  void clear_has_optime();

  // helper for ByteSizeLong()
  size_t RequiredFieldsByteSizeFallback() const;

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  template <typename T> friend class ::google::protobuf::Arena::InternalHelper;
  typedef void InternalArenaConstructable_;
  typedef void DestructorSkippable_;
  ::google::protobuf::internal::HasBits<1> _has_bits_;
  mutable ::google::protobuf::internal::CachedSize _cached_size_;
  ::google::protobuf::internal::ArenaStringPtr module_;
  ::google::protobuf::internal::ArenaStringPtr id_;
  ::google::protobuf::internal::ArenaStringPtr l_val_;
  ::google::protobuf::internal::ArenaStringPtr c_key_;
  ::google::protobuf::internal::ArenaStringPtr c_val_;
  ::google::protobuf::internal::ArenaStringPtr mainid_;
  ::google::protobuf::int64 optime_;
  friend struct ::protobuf_RedisLuaTableDump_2eproto::TableStruct;
};
// ===================================================================


// ===================================================================

#ifdef __GNUC__
  #pragma GCC diagnostic push
  #pragma GCC diagnostic ignored "-Wstrict-aliasing"
#endif  // __GNUC__
// RedisListLuaTableDump

// required bytes module = 1;
inline bool RedisListLuaTableDump::has_module() const {
  return (_has_bits_[0] & 0x00000001u) != 0;
}
inline void RedisListLuaTableDump::set_has_module() {
  _has_bits_[0] |= 0x00000001u;
}
inline void RedisListLuaTableDump::clear_has_module() {
  _has_bits_[0] &= ~0x00000001u;
}
inline void RedisListLuaTableDump::clear_module() {
  module_.ClearToEmpty(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), GetArenaNoVirtual());
  clear_has_module();
}
inline const ::std::string& RedisListLuaTableDump::module() const {
  // @@protoc_insertion_point(field_get:db.RedisListLuaTableDump.module)
  return module_.Get();
}
inline void RedisListLuaTableDump::set_module(const ::std::string& value) {
  set_has_module();
  module_.Set(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), value, GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set:db.RedisListLuaTableDump.module)
}
#if LANG_CXX11
inline void RedisListLuaTableDump::set_module(::std::string&& value) {
  set_has_module();
  module_.Set(
    &::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::move(value), GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set_rvalue:db.RedisListLuaTableDump.module)
}
#endif
inline void RedisListLuaTableDump::set_module(const char* value) {
  GOOGLE_DCHECK(value != NULL);
  set_has_module();
  module_.Set(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(value),
              GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set_char:db.RedisListLuaTableDump.module)
}
inline void RedisListLuaTableDump::set_module(const void* value,
    size_t size) {
  set_has_module();
  module_.Set(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(
      reinterpret_cast<const char*>(value), size), GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set_pointer:db.RedisListLuaTableDump.module)
}
inline ::std::string* RedisListLuaTableDump::mutable_module() {
  set_has_module();
  // @@protoc_insertion_point(field_mutable:db.RedisListLuaTableDump.module)
  return module_.Mutable(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), GetArenaNoVirtual());
}
inline ::std::string* RedisListLuaTableDump::release_module() {
  // @@protoc_insertion_point(field_release:db.RedisListLuaTableDump.module)
  if (!has_module()) {
    return NULL;
  }
  clear_has_module();
  return module_.ReleaseNonDefault(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), GetArenaNoVirtual());
}
inline void RedisListLuaTableDump::set_allocated_module(::std::string* module) {
  if (module != NULL) {
    set_has_module();
  } else {
    clear_has_module();
  }
  module_.SetAllocated(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), module,
      GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set_allocated:db.RedisListLuaTableDump.module)
}
inline ::std::string* RedisListLuaTableDump::unsafe_arena_release_module() {
  // @@protoc_insertion_point(field_unsafe_arena_release:db.RedisListLuaTableDump.module)
  GOOGLE_DCHECK(GetArenaNoVirtual() != NULL);
  clear_has_module();
  return module_.UnsafeArenaRelease(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      GetArenaNoVirtual());
}
inline void RedisListLuaTableDump::unsafe_arena_set_allocated_module(
    ::std::string* module) {
  GOOGLE_DCHECK(GetArenaNoVirtual() != NULL);
  if (module != NULL) {
    set_has_module();
  } else {
    clear_has_module();
  }
  module_.UnsafeArenaSetAllocated(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      module, GetArenaNoVirtual());
  // @@protoc_insertion_point(field_unsafe_arena_set_allocated:db.RedisListLuaTableDump.module)
}

// required bytes id = 2;
inline bool RedisListLuaTableDump::has_id() const {
  return (_has_bits_[0] & 0x00000002u) != 0;
}
inline void RedisListLuaTableDump::set_has_id() {
  _has_bits_[0] |= 0x00000002u;
}
inline void RedisListLuaTableDump::clear_has_id() {
  _has_bits_[0] &= ~0x00000002u;
}
inline void RedisListLuaTableDump::clear_id() {
  id_.ClearToEmpty(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), GetArenaNoVirtual());
  clear_has_id();
}
inline const ::std::string& RedisListLuaTableDump::id() const {
  // @@protoc_insertion_point(field_get:db.RedisListLuaTableDump.id)
  return id_.Get();
}
inline void RedisListLuaTableDump::set_id(const ::std::string& value) {
  set_has_id();
  id_.Set(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), value, GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set:db.RedisListLuaTableDump.id)
}
#if LANG_CXX11
inline void RedisListLuaTableDump::set_id(::std::string&& value) {
  set_has_id();
  id_.Set(
    &::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::move(value), GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set_rvalue:db.RedisListLuaTableDump.id)
}
#endif
inline void RedisListLuaTableDump::set_id(const char* value) {
  GOOGLE_DCHECK(value != NULL);
  set_has_id();
  id_.Set(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(value),
              GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set_char:db.RedisListLuaTableDump.id)
}
inline void RedisListLuaTableDump::set_id(const void* value,
    size_t size) {
  set_has_id();
  id_.Set(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(
      reinterpret_cast<const char*>(value), size), GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set_pointer:db.RedisListLuaTableDump.id)
}
inline ::std::string* RedisListLuaTableDump::mutable_id() {
  set_has_id();
  // @@protoc_insertion_point(field_mutable:db.RedisListLuaTableDump.id)
  return id_.Mutable(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), GetArenaNoVirtual());
}
inline ::std::string* RedisListLuaTableDump::release_id() {
  // @@protoc_insertion_point(field_release:db.RedisListLuaTableDump.id)
  if (!has_id()) {
    return NULL;
  }
  clear_has_id();
  return id_.ReleaseNonDefault(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), GetArenaNoVirtual());
}
inline void RedisListLuaTableDump::set_allocated_id(::std::string* id) {
  if (id != NULL) {
    set_has_id();
  } else {
    clear_has_id();
  }
  id_.SetAllocated(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), id,
      GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set_allocated:db.RedisListLuaTableDump.id)
}
inline ::std::string* RedisListLuaTableDump::unsafe_arena_release_id() {
  // @@protoc_insertion_point(field_unsafe_arena_release:db.RedisListLuaTableDump.id)
  GOOGLE_DCHECK(GetArenaNoVirtual() != NULL);
  clear_has_id();
  return id_.UnsafeArenaRelease(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      GetArenaNoVirtual());
}
inline void RedisListLuaTableDump::unsafe_arena_set_allocated_id(
    ::std::string* id) {
  GOOGLE_DCHECK(GetArenaNoVirtual() != NULL);
  if (id != NULL) {
    set_has_id();
  } else {
    clear_has_id();
  }
  id_.UnsafeArenaSetAllocated(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      id, GetArenaNoVirtual());
  // @@protoc_insertion_point(field_unsafe_arena_set_allocated:db.RedisListLuaTableDump.id)
}

// required bytes l_val = 3;
inline bool RedisListLuaTableDump::has_l_val() const {
  return (_has_bits_[0] & 0x00000004u) != 0;
}
inline void RedisListLuaTableDump::set_has_l_val() {
  _has_bits_[0] |= 0x00000004u;
}
inline void RedisListLuaTableDump::clear_has_l_val() {
  _has_bits_[0] &= ~0x00000004u;
}
inline void RedisListLuaTableDump::clear_l_val() {
  l_val_.ClearToEmpty(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), GetArenaNoVirtual());
  clear_has_l_val();
}
inline const ::std::string& RedisListLuaTableDump::l_val() const {
  // @@protoc_insertion_point(field_get:db.RedisListLuaTableDump.l_val)
  return l_val_.Get();
}
inline void RedisListLuaTableDump::set_l_val(const ::std::string& value) {
  set_has_l_val();
  l_val_.Set(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), value, GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set:db.RedisListLuaTableDump.l_val)
}
#if LANG_CXX11
inline void RedisListLuaTableDump::set_l_val(::std::string&& value) {
  set_has_l_val();
  l_val_.Set(
    &::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::move(value), GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set_rvalue:db.RedisListLuaTableDump.l_val)
}
#endif
inline void RedisListLuaTableDump::set_l_val(const char* value) {
  GOOGLE_DCHECK(value != NULL);
  set_has_l_val();
  l_val_.Set(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(value),
              GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set_char:db.RedisListLuaTableDump.l_val)
}
inline void RedisListLuaTableDump::set_l_val(const void* value,
    size_t size) {
  set_has_l_val();
  l_val_.Set(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(
      reinterpret_cast<const char*>(value), size), GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set_pointer:db.RedisListLuaTableDump.l_val)
}
inline ::std::string* RedisListLuaTableDump::mutable_l_val() {
  set_has_l_val();
  // @@protoc_insertion_point(field_mutable:db.RedisListLuaTableDump.l_val)
  return l_val_.Mutable(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), GetArenaNoVirtual());
}
inline ::std::string* RedisListLuaTableDump::release_l_val() {
  // @@protoc_insertion_point(field_release:db.RedisListLuaTableDump.l_val)
  if (!has_l_val()) {
    return NULL;
  }
  clear_has_l_val();
  return l_val_.ReleaseNonDefault(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), GetArenaNoVirtual());
}
inline void RedisListLuaTableDump::set_allocated_l_val(::std::string* l_val) {
  if (l_val != NULL) {
    set_has_l_val();
  } else {
    clear_has_l_val();
  }
  l_val_.SetAllocated(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), l_val,
      GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set_allocated:db.RedisListLuaTableDump.l_val)
}
inline ::std::string* RedisListLuaTableDump::unsafe_arena_release_l_val() {
  // @@protoc_insertion_point(field_unsafe_arena_release:db.RedisListLuaTableDump.l_val)
  GOOGLE_DCHECK(GetArenaNoVirtual() != NULL);
  clear_has_l_val();
  return l_val_.UnsafeArenaRelease(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      GetArenaNoVirtual());
}
inline void RedisListLuaTableDump::unsafe_arena_set_allocated_l_val(
    ::std::string* l_val) {
  GOOGLE_DCHECK(GetArenaNoVirtual() != NULL);
  if (l_val != NULL) {
    set_has_l_val();
  } else {
    clear_has_l_val();
  }
  l_val_.UnsafeArenaSetAllocated(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      l_val, GetArenaNoVirtual());
  // @@protoc_insertion_point(field_unsafe_arena_set_allocated:db.RedisListLuaTableDump.l_val)
}

// required bytes c_key = 4;
inline bool RedisListLuaTableDump::has_c_key() const {
  return (_has_bits_[0] & 0x00000008u) != 0;
}
inline void RedisListLuaTableDump::set_has_c_key() {
  _has_bits_[0] |= 0x00000008u;
}
inline void RedisListLuaTableDump::clear_has_c_key() {
  _has_bits_[0] &= ~0x00000008u;
}
inline void RedisListLuaTableDump::clear_c_key() {
  c_key_.ClearToEmpty(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), GetArenaNoVirtual());
  clear_has_c_key();
}
inline const ::std::string& RedisListLuaTableDump::c_key() const {
  // @@protoc_insertion_point(field_get:db.RedisListLuaTableDump.c_key)
  return c_key_.Get();
}
inline void RedisListLuaTableDump::set_c_key(const ::std::string& value) {
  set_has_c_key();
  c_key_.Set(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), value, GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set:db.RedisListLuaTableDump.c_key)
}
#if LANG_CXX11
inline void RedisListLuaTableDump::set_c_key(::std::string&& value) {
  set_has_c_key();
  c_key_.Set(
    &::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::move(value), GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set_rvalue:db.RedisListLuaTableDump.c_key)
}
#endif
inline void RedisListLuaTableDump::set_c_key(const char* value) {
  GOOGLE_DCHECK(value != NULL);
  set_has_c_key();
  c_key_.Set(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(value),
              GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set_char:db.RedisListLuaTableDump.c_key)
}
inline void RedisListLuaTableDump::set_c_key(const void* value,
    size_t size) {
  set_has_c_key();
  c_key_.Set(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(
      reinterpret_cast<const char*>(value), size), GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set_pointer:db.RedisListLuaTableDump.c_key)
}
inline ::std::string* RedisListLuaTableDump::mutable_c_key() {
  set_has_c_key();
  // @@protoc_insertion_point(field_mutable:db.RedisListLuaTableDump.c_key)
  return c_key_.Mutable(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), GetArenaNoVirtual());
}
inline ::std::string* RedisListLuaTableDump::release_c_key() {
  // @@protoc_insertion_point(field_release:db.RedisListLuaTableDump.c_key)
  if (!has_c_key()) {
    return NULL;
  }
  clear_has_c_key();
  return c_key_.ReleaseNonDefault(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), GetArenaNoVirtual());
}
inline void RedisListLuaTableDump::set_allocated_c_key(::std::string* c_key) {
  if (c_key != NULL) {
    set_has_c_key();
  } else {
    clear_has_c_key();
  }
  c_key_.SetAllocated(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), c_key,
      GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set_allocated:db.RedisListLuaTableDump.c_key)
}
inline ::std::string* RedisListLuaTableDump::unsafe_arena_release_c_key() {
  // @@protoc_insertion_point(field_unsafe_arena_release:db.RedisListLuaTableDump.c_key)
  GOOGLE_DCHECK(GetArenaNoVirtual() != NULL);
  clear_has_c_key();
  return c_key_.UnsafeArenaRelease(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      GetArenaNoVirtual());
}
inline void RedisListLuaTableDump::unsafe_arena_set_allocated_c_key(
    ::std::string* c_key) {
  GOOGLE_DCHECK(GetArenaNoVirtual() != NULL);
  if (c_key != NULL) {
    set_has_c_key();
  } else {
    clear_has_c_key();
  }
  c_key_.UnsafeArenaSetAllocated(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      c_key, GetArenaNoVirtual());
  // @@protoc_insertion_point(field_unsafe_arena_set_allocated:db.RedisListLuaTableDump.c_key)
}

// required bytes c_val = 5;
inline bool RedisListLuaTableDump::has_c_val() const {
  return (_has_bits_[0] & 0x00000010u) != 0;
}
inline void RedisListLuaTableDump::set_has_c_val() {
  _has_bits_[0] |= 0x00000010u;
}
inline void RedisListLuaTableDump::clear_has_c_val() {
  _has_bits_[0] &= ~0x00000010u;
}
inline void RedisListLuaTableDump::clear_c_val() {
  c_val_.ClearToEmpty(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), GetArenaNoVirtual());
  clear_has_c_val();
}
inline const ::std::string& RedisListLuaTableDump::c_val() const {
  // @@protoc_insertion_point(field_get:db.RedisListLuaTableDump.c_val)
  return c_val_.Get();
}
inline void RedisListLuaTableDump::set_c_val(const ::std::string& value) {
  set_has_c_val();
  c_val_.Set(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), value, GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set:db.RedisListLuaTableDump.c_val)
}
#if LANG_CXX11
inline void RedisListLuaTableDump::set_c_val(::std::string&& value) {
  set_has_c_val();
  c_val_.Set(
    &::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::move(value), GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set_rvalue:db.RedisListLuaTableDump.c_val)
}
#endif
inline void RedisListLuaTableDump::set_c_val(const char* value) {
  GOOGLE_DCHECK(value != NULL);
  set_has_c_val();
  c_val_.Set(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(value),
              GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set_char:db.RedisListLuaTableDump.c_val)
}
inline void RedisListLuaTableDump::set_c_val(const void* value,
    size_t size) {
  set_has_c_val();
  c_val_.Set(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(
      reinterpret_cast<const char*>(value), size), GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set_pointer:db.RedisListLuaTableDump.c_val)
}
inline ::std::string* RedisListLuaTableDump::mutable_c_val() {
  set_has_c_val();
  // @@protoc_insertion_point(field_mutable:db.RedisListLuaTableDump.c_val)
  return c_val_.Mutable(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), GetArenaNoVirtual());
}
inline ::std::string* RedisListLuaTableDump::release_c_val() {
  // @@protoc_insertion_point(field_release:db.RedisListLuaTableDump.c_val)
  if (!has_c_val()) {
    return NULL;
  }
  clear_has_c_val();
  return c_val_.ReleaseNonDefault(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), GetArenaNoVirtual());
}
inline void RedisListLuaTableDump::set_allocated_c_val(::std::string* c_val) {
  if (c_val != NULL) {
    set_has_c_val();
  } else {
    clear_has_c_val();
  }
  c_val_.SetAllocated(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), c_val,
      GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set_allocated:db.RedisListLuaTableDump.c_val)
}
inline ::std::string* RedisListLuaTableDump::unsafe_arena_release_c_val() {
  // @@protoc_insertion_point(field_unsafe_arena_release:db.RedisListLuaTableDump.c_val)
  GOOGLE_DCHECK(GetArenaNoVirtual() != NULL);
  clear_has_c_val();
  return c_val_.UnsafeArenaRelease(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      GetArenaNoVirtual());
}
inline void RedisListLuaTableDump::unsafe_arena_set_allocated_c_val(
    ::std::string* c_val) {
  GOOGLE_DCHECK(GetArenaNoVirtual() != NULL);
  if (c_val != NULL) {
    set_has_c_val();
  } else {
    clear_has_c_val();
  }
  c_val_.UnsafeArenaSetAllocated(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      c_val, GetArenaNoVirtual());
  // @@protoc_insertion_point(field_unsafe_arena_set_allocated:db.RedisListLuaTableDump.c_val)
}

// required bytes mainid = 6;
inline bool RedisListLuaTableDump::has_mainid() const {
  return (_has_bits_[0] & 0x00000020u) != 0;
}
inline void RedisListLuaTableDump::set_has_mainid() {
  _has_bits_[0] |= 0x00000020u;
}
inline void RedisListLuaTableDump::clear_has_mainid() {
  _has_bits_[0] &= ~0x00000020u;
}
inline void RedisListLuaTableDump::clear_mainid() {
  mainid_.ClearToEmpty(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), GetArenaNoVirtual());
  clear_has_mainid();
}
inline const ::std::string& RedisListLuaTableDump::mainid() const {
  // @@protoc_insertion_point(field_get:db.RedisListLuaTableDump.mainid)
  return mainid_.Get();
}
inline void RedisListLuaTableDump::set_mainid(const ::std::string& value) {
  set_has_mainid();
  mainid_.Set(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), value, GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set:db.RedisListLuaTableDump.mainid)
}
#if LANG_CXX11
inline void RedisListLuaTableDump::set_mainid(::std::string&& value) {
  set_has_mainid();
  mainid_.Set(
    &::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::move(value), GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set_rvalue:db.RedisListLuaTableDump.mainid)
}
#endif
inline void RedisListLuaTableDump::set_mainid(const char* value) {
  GOOGLE_DCHECK(value != NULL);
  set_has_mainid();
  mainid_.Set(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(value),
              GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set_char:db.RedisListLuaTableDump.mainid)
}
inline void RedisListLuaTableDump::set_mainid(const void* value,
    size_t size) {
  set_has_mainid();
  mainid_.Set(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(
      reinterpret_cast<const char*>(value), size), GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set_pointer:db.RedisListLuaTableDump.mainid)
}
inline ::std::string* RedisListLuaTableDump::mutable_mainid() {
  set_has_mainid();
  // @@protoc_insertion_point(field_mutable:db.RedisListLuaTableDump.mainid)
  return mainid_.Mutable(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), GetArenaNoVirtual());
}
inline ::std::string* RedisListLuaTableDump::release_mainid() {
  // @@protoc_insertion_point(field_release:db.RedisListLuaTableDump.mainid)
  if (!has_mainid()) {
    return NULL;
  }
  clear_has_mainid();
  return mainid_.ReleaseNonDefault(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), GetArenaNoVirtual());
}
inline void RedisListLuaTableDump::set_allocated_mainid(::std::string* mainid) {
  if (mainid != NULL) {
    set_has_mainid();
  } else {
    clear_has_mainid();
  }
  mainid_.SetAllocated(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), mainid,
      GetArenaNoVirtual());
  // @@protoc_insertion_point(field_set_allocated:db.RedisListLuaTableDump.mainid)
}
inline ::std::string* RedisListLuaTableDump::unsafe_arena_release_mainid() {
  // @@protoc_insertion_point(field_unsafe_arena_release:db.RedisListLuaTableDump.mainid)
  GOOGLE_DCHECK(GetArenaNoVirtual() != NULL);
  clear_has_mainid();
  return mainid_.UnsafeArenaRelease(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      GetArenaNoVirtual());
}
inline void RedisListLuaTableDump::unsafe_arena_set_allocated_mainid(
    ::std::string* mainid) {
  GOOGLE_DCHECK(GetArenaNoVirtual() != NULL);
  if (mainid != NULL) {
    set_has_mainid();
  } else {
    clear_has_mainid();
  }
  mainid_.UnsafeArenaSetAllocated(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      mainid, GetArenaNoVirtual());
  // @@protoc_insertion_point(field_unsafe_arena_set_allocated:db.RedisListLuaTableDump.mainid)
}

// optional sfixed64 optime = 11;
inline bool RedisListLuaTableDump::has_optime() const {
  return (_has_bits_[0] & 0x00000040u) != 0;
}
inline void RedisListLuaTableDump::set_has_optime() {
  _has_bits_[0] |= 0x00000040u;
}
inline void RedisListLuaTableDump::clear_has_optime() {
  _has_bits_[0] &= ~0x00000040u;
}
inline void RedisListLuaTableDump::clear_optime() {
  optime_ = GOOGLE_LONGLONG(0);
  clear_has_optime();
}
inline ::google::protobuf::int64 RedisListLuaTableDump::optime() const {
  // @@protoc_insertion_point(field_get:db.RedisListLuaTableDump.optime)
  return optime_;
}
inline void RedisListLuaTableDump::set_optime(::google::protobuf::int64 value) {
  set_has_optime();
  optime_ = value;
  // @@protoc_insertion_point(field_set:db.RedisListLuaTableDump.optime)
}

#ifdef __GNUC__
  #pragma GCC diagnostic pop
#endif  // __GNUC__

// @@protoc_insertion_point(namespace_scope)

}  // namespace db

// @@protoc_insertion_point(global_scope)

#endif  // PROTOBUF_INCLUDED_RedisLuaTableDump_2eproto