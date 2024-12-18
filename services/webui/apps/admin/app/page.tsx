import Link from "next/link";

export default function Home() {
  return (
    <main>
      <div className="flex items-center justify-center min-h-screen">
        <div className="grid grid-cols-3 gap-4">
          <Link href="/manage">
            <div className="p-4 bg-gray-900 rounded-lg shadow-md hover:shadow-lg cursor-pointer">
              <h2 className="text-lg font-bold">アーティスト楽曲管理</h2>
              <p>Manage artists, albums, and tracks</p>
            </div>
          </Link>
          <Link href="/analytics">
            <div className="p-4 bg-gray-900 rounded-lg shadow-md hover:shadow-lg cursor-pointer">
              <h2 className="text-lg font-bold">アナリティクス</h2>
              <p>View analytics</p>
            </div>
          </Link>
          <Link href="/system">
            <div className="p-4 bg-gray-900 rounded-lg shadow-md hover:shadow-lg cursor-pointer">
              <h2 className="text-lg font-bold">システム管理</h2>
              <p>settings</p>
            </div>
          </Link>
        </div>
      </div>
    </main>
  );
}
