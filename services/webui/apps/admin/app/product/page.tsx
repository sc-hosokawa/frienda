"use client";

import Image from "next/image";
import { useQuery } from "@tanstack/react-query";
import request from "graphql-request";
import { endpoint, SEARCH_PRODUCTS } from "../../utils/query";
import { useState } from "react";
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
} from "@ui/components/ui/card";
import { Input } from "@ui/components/ui/input";
import { Button } from "@ui/components/ui/button";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@ui/components/ui/select";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@ui/components/ui/table";
import { Label } from "@ui/components/ui/label";
import { ImageOff } from "lucide-react";
import { EditDialog } from "../../components/manage/product-management";
import Link from "next/link";

interface Product {
  upc: string;
  title: string;
  imgUrl: string | null;
  productType: string;
  distributedAt: string;
  artistId: string;
  artistNameJa: string;
  numberOfTracks: number;
}

interface SearchProductsResponse {
  searchProducts: Product[];
}

interface SearchForm {
  upc?: string;
  productTitle?: string;
  productType?: string;
}

export default function ProductManagementPage() {
  const [formData, setFormData] = useState<SearchForm>({});
  const [hasSearched, setHasSearched] = useState(false);
  const [selectedProduct, setSelectedProduct] = useState<Product | null>(null);
  const [isEditDialogOpen, setIsEditDialogOpen] = useState(false);

  const searchProducts = useQuery<SearchProductsResponse>({
    queryKey: ["searchProducts", formData],
    queryFn: () => request(endpoint, SEARCH_PRODUCTS, { input: formData }),
    enabled: false,
  });

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    setHasSearched(true);
    searchProducts.refetch();
  };

  const handleFormChange = (newData: Partial<SearchForm>) => {
    setFormData((prev) => ({ ...prev, ...newData }));
  };

  const handleClear = () => {
    setFormData({});
    setHasSearched(false);
  };

  const products = searchProducts.data?.searchProducts ?? [];

  console.log(searchProducts.data);
  console.log(formData);

  const handleEditClick = (product: Product) => {
    setSelectedProduct(product);
    setIsEditDialogOpen(true);
  };

  return (
    <>
      <div className="flex min-h-screen">
        <div className="w-1/4 p-6 border-r border-border">
          <Card>
            <CardHeader>
              <CardTitle>作品検索</CardTitle>
            </CardHeader>
            <CardContent>
              <form onSubmit={handleSearch} className="space-y-4">
                <div className="space-y-2">
                  <Label htmlFor="upc">UPC</Label>
                  <Input
                    id="upc"
                    value={formData.upc || ""}
                    placeholder="UPCを入力"
                    onChange={(e) => handleFormChange({ upc: e.target.value })}
                  />
                </div>

                <div className="space-y-2">
                  <Label htmlFor="title">タイトル</Label>
                  <Input
                    id="title"
                    value={formData.productTitle || ""}
                    placeholder="タイトルを入力"
                    onChange={(e) =>
                      handleFormChange({ productTitle: e.target.value })
                    }
                  />
                </div>

                <div className="space-y-2">
                  <Label htmlFor="productType">タイプ</Label>
                  <Select
                    value={formData.productType}
                    onValueChange={(value) =>
                      handleFormChange({ productType: value })
                    }
                  >
                    <SelectTrigger>
                      <SelectValue placeholder="タイプを選択（アルバム、シングル、EP）" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="album">アルバム</SelectItem>
                      <SelectItem value="single">シングル</SelectItem>
                      <SelectItem value="ep">EP</SelectItem>
                    </SelectContent>
                  </Select>
                </div>

                <Button
                  type="submit"
                  className="w-full"
                  disabled={searchProducts.isFetching}
                >
                  {searchProducts.isFetching ? "検索中..." : "検索"}
                </Button>

                <Button
                  type="button"
                  variant="outline"
                  className="w-full"
                  onClick={handleClear}
                >
                  クリア
                </Button>
              </form>
            </CardContent>
          </Card>

          <div className="mt-4 mr-4 text-right">
            <Link href="/manage/track" className="w-full underline">
              トラックの管理はこちら
            </Link>
          </div>
        </div>

        {/* Right Section - Results */}
        <div className="w-3/4 p-6">
          <Card>
            <CardContent>
              {searchProducts.isFetching ? (
                <div className="flex items-center justify-center h-32">
                  <svg
                    className="animate-spin h-8 w-8 text-primary"
                    xmlns="http://www.w3.org/2000/svg"
                    fill="none"
                    viewBox="0 0 24 24"
                  >
                    <circle
                      className="opacity-25"
                      cx="12"
                      cy="12"
                      r="10"
                      stroke="currentColor"
                      strokeWidth="4"
                    ></circle>
                    <path
                      className="opacity-75"
                      fill="currentColor"
                      d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
                    ></path>
                  </svg>
                </div>
              ) : !hasSearched ? (
                <div className="flex items-center justify-center h-32 text-muted-foreground">
                  検索してください
                </div>
              ) : products.length === 0 ? (
                <div className="flex items-center justify-center h-32 text-muted-foreground">
                  該当するデータがありません。
                </div>
              ) : (
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead></TableHead>
                      <TableHead className="text-center">UPC</TableHead>
                      <TableHead className="text-center">タイトル</TableHead>
                      <TableHead className="text-center">タイプ</TableHead>
                      <TableHead className="text-center">
                        アーティスト
                      </TableHead>
                      <TableHead className="text-center">操作</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {products.map((product) => (
                      <TableRow key={product.upc}>
                        <TableCell className="flex items-center justify-center">
                          {product.imgUrl ? (
                            <Image
                              src={product.imgUrl}
                              alt={product.title}
                              width={100}
                              height={100}
                              className="rounded-md"
                            />
                          ) : (
                            <div className="w-[100px] h-[100px] flex items-center justify-center bg-muted rounded-md">
                              <ImageOff className="w-8 h-8 text-muted-foreground" />
                            </div>
                          )}
                        </TableCell>
                        <TableCell className="text-center">
                          {product.upc}
                        </TableCell>
                        <TableCell className="text-center">
                          {product.title}
                        </TableCell>
                        <TableCell className="text-center">
                          {product.productType}
                        </TableCell>
                        <TableCell className="text-center">
                          {product.artistNameJa}
                        </TableCell>
                        <TableCell className="text-center">
                          <Button
                            variant="default"
                            size="sm"
                            onClick={() => handleEditClick(product)}
                          >
                            編集
                          </Button>
                        </TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              )}
            </CardContent>
          </Card>
        </div>
      </div>

      <EditDialog
        product={selectedProduct}
        open={isEditDialogOpen}
        onOpenChange={setIsEditDialogOpen}
        onSuccess={() => {
          setSelectedProduct(null);
          searchProducts.refetch();
        }}
      />
    </>
  );
}
