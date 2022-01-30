module collections.set;

import collections.collection;

class Set(T) : Collection!T
{
    private bool[T] _dict;

    override bool add(T elem)
    {
        if (elem in _dict)
            return false;
        _dict[elem] = true;
        return true;
    }

    override size_t add(T[] elements...)
    {
        size_t c = 0;
        foreach (ref e; elements)
        {
            if (add(e))
                c++;
        }
        return c;
    }

    override bool remove(T elem)
    {
        return _dict.remove(elem);
    }
    override size_t remove(T[] elements...)
    {
        size_t c = 0;
        foreach (ref e; elements)
        {
            if (remove(e))
                c++;
        }
        return c;
    }

    override bool contains(T[] elements...)
    {
        foreach (ref e; elements)
        {
            if (!(e in _dict))
                return false;
        }
        return true;
    }

    override size_t size() const
    {
        return _dict.length;
    }

    override Iterator!T itr() const
    {
        auto _state = _dict.byKey();

        class SetIterator(T) : Iterator!T
        {
            override @property T front() const
            {
                return _state.front();
            }

            override @property bool empty() const
            {
                return _state.empty();
            }

            override void popFront()
            {
                _state.popFront();
            }
        }

        return new SetIterator!T;
    }
}
