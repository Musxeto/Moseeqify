import React, { useEffect, useState } from "react";
import { CiSearch } from "react-icons/ci";

const Search = () => {
  const [query, setQuery] = useState("");
  const [results, setResults] = useState([]);

  useEffect(() => {
    if (query.trim() === "") {
      setResults([]);
      return;
    }

    const fetchResults = async () => {
      try {
        const response = await fetch("http://localhost:5000/search", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ query }),
        });

        if (response.ok) {
          const data = await response.json();
          setResults(data);
        } else {
          console.error("Search failed.");
        }
      } catch (error) {
        console.error("Error occurred during search:", error);
      }
    };

    fetchResults();
  }, [query]);

  return (
    <div className="relative">
      <input
        type="text"
        value={query}
        onChange={(e) => setQuery(e.target.value)}
        placeholder="Search"
        className="p-2 pl-8 border-2 border-red-500 rounded-lg bg-black text-white"
      />
      <button
        onClick={() => {}}
        className="absolute text-2xl top-2 left-2 text-white"
      >
        <CiSearch />
      </button>
      {results.length > 0 && (
        <div className="absolute bg-black text-white mt-2 w-full rounded-lg shadow-lg">
          {results.map((song) => (
            <div key={song.id} className="p-2 border-b border-gray-600">
              {song.title}
            </div>
          ))}
        </div>
      )}
    </div>
  );
};

export default Search;
