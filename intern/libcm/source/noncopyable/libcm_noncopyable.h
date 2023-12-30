//
// Created by USER on 2023-12-15.
//

#ifndef INTERN_LIBCM_NONCOPYABLE_H
#define INTERN_LIBCM_NONCOPYABLE_H

// --------------------------------------------------
// NOTE: check Google C++ code standard...
// Ref 1 : https://google.github.io/styleguide/cppguide.html#Copyable_Movable_Types
// Ref 2 : https://en.wikibooks.org/wiki/More_C%2B%2B_Idioms/Non-copyable_Mixin

namespace MK
{
	// NOTE: A copyable class should explicitly declare the copy operations
	class Copyable 
    {
	protected: Copyable() = default;
	protected: ~Copyable() = default;
	protected: Copyable(const Copyable& other) = default;
	protected: Copyable& operator=(const Copyable& other) = default;
	// The implicit move operations are suppressed by the declarations above.
	// You may explicitly declare move operations to support efficient moves.
	};

	class NonCopyable
	{
	protected: NonCopyable() = default;
	protected: ~NonCopyable() = default;
	public: NonCopyable( const NonCopyable& ) = delete;
	public: NonCopyable& operator=( const NonCopyable& ) = delete;
	};

	// NOTE: move-only class should explicitly declare the move operations
	class MoveOnly
	{
	protected: MoveOnly() = default;
	protected: ~MoveOnly() = default;
	protected: MoveOnly (MoveOnly&&) = default;
	protected: MoveOnly& operator= (MoveOnly&&) = default;
	// The copy operations are implicitly deleted, but you can spell that out explicitly if you want:
	public: MoveOnly(const MoveOnly&) = delete;
	public: MoveOnly& operator=(const MoveOnly&) = delete;
	};

	class NonCopyableOrMovable
	{
	public: NonCopyableOrMovable (const NonCopyableOrMovable&) = delete;
	public: NonCopyableOrMovable& operator= (const NonCopyableOrMovable&) = delete;
	// The move operations are implicitly disabled, but you can spell that out explicitly if you want:
	public: NonCopyableOrMovable (NonCopyableOrMovable&&) = delete;
	public: NonCopyableOrMovable& operator= (NonCopyableOrMovable&&) = delete;
	};

}

#endif //INTERN_LIBCM_NONCOPYABLE_H