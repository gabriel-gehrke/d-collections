module collections.collection;

import std.range.interfaces;
import std.conv : to;

abstract class Collection(T)
{
    bool add(T elem);
    size_t add(T[] elements...);

    bool remove(T elem);
    size_t remove(T[] elem...);

    bool contains(T[] elements...);

    size_t size() const;
    Iterator!T itr() const;

    @property bool empty() const
    {
        return size() == 0;
    }

    void forEach(void delegate(size_t i, T elem) func) const
    {
        itr().forEach(func);
    }

    T[] toArray() const
    {
        T[] arr;
        arr.length = size();

        void __arr_insert(size_t i, T e)
        {
            arr[i] = e;
        }

        this.forEach(&__arr_insert);
        return arr;
    }

    override string toString() const
    {
        return to!string(toArray());
    }

}

/** 
 * should conform with Ranges from std.ranges
 */
interface Iterator(T)
{
    @property T front() const;

    @property bool empty() const;

    void popFront();

    final void forEach(void delegate(size_t i, T elem) func)
    {
        scope size_t i = 0;
        while (!this.empty) {
            func(i, this.front);
            this.popFront();
            i++;
        }
    }
}