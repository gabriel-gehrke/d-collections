module collections.list;

import collections.collection;
import std.conv : to;

class List(T) : Collection!T
{
    private T[] _array;

    this()
    {
        _array = [];
    }

    this(T[] elements...)
    {
        _array = elements.dup;
    }

    // overridden operators

    ref T opIndex(size_t i)
    {
        return _array[i];
    }

    final @property size_t opDollar()
    {
        return size();
    }

    // collection methods

    override bool add(T elem)
    {
        _array ~= elem;
        return true;
    }

    override size_t add(T[] elements...)
    {
        _array ~= elements;
        return elements.length;
    }

    override bool contains(T[] elements...)
    {
        outer: foreach (ref e; elements)
        {
            foreach (ref x; _array)
            {
                if (e == x)
                {
                    continue outer;
                }
            }
            return false;
        }
        return true;
    }

    override bool remove(T elem)
    {
        return remove(elem) == 1;
    }

    override size_t remove(T[] elements...)
    {
        size_t count = 0;

        foreach (ref e; elements)
        {
            auto i = indexof(e);

            if (i >= size())
            {
                continue;
            }

            count++;
            _array = _array[0 .. i] ~ _array[(i + 1) .. $];
        }

        return count;
    }

    // returns the index of the first occurence of the given item
    size_t indexof(T elem)
    {
        foreach (i, ref e; _array)
        {
            if (e == elem)
                return i;
        }
        return size();
    }

    override size_t size() const
    {
        return _array.length;
    }

    override final string toString() const
    {
        return to!string(_array);
    }

    override Iterator!T itr() const
    {
        class ListIterator : Iterator!T
        {
            private size_t _state = 0;

            override @property T front() const
            {
                return _array[_state];
            }

            override @property bool empty() const
            {
                return (size() - _state) == 0;
            }

            override void popFront()
            {
                _state++;
            }

        }

        return new ListIterator;
    }

}
