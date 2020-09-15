import { fetchMilestone } from "./mod.ts";
import { assert } from "https://deno.land/std/testing/asserts.ts";

// Taken from https://dev.to/brunnerlivio/create-your-first-module-with-deno-575k#getting-started-with-the-file-structure

Deno.test( "Probando fetchMilestone",
           async () =>  {
               const response = await fetchMilestone("Raku","doc",2);
               assert(response);
               await response.arrayBuffer();
           },
);
